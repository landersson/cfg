#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import sys
import re
import argparse
from collections import Counter

def parse_xunit_to_quickfix(xml_file, include_patterns=None, exclude_patterns=None, show_stats=False):
    """
    Parse xunit XML file and output quickfix format or statistics.

    Args:
        xml_file: Path to xunit XML file
        include_patterns: List of patterns; only include lints matching ANY pattern
        exclude_patterns: List of patterns; exclude lints matching ANY pattern
        show_stats: If True, show statistics instead of quickfix output
    """
    tree = ET.parse(xml_file)
    root = tree.getroot()

    # Detect the lint tool type from testsuite name
    testsuite_name = root.get('name', '')
    is_cpplint = 'cpplint' in testsuite_name.lower()

    if show_stats:
        error_types = Counter()

    for testcase in root.findall('.//testcase'):
        failure = testcase.find('failure')
        if failure is not None:
            # Parse the location from testcase name attribute
            name = testcase.get('name', '')

            if is_cpplint:
                # cpplint format: "error_type [level] (/path/to/file.cpp:line)"
                match = re.search(r'\(([^)]+):(\d+)\)', name)
                if match:
                    filepath, line = match.groups()
                    col = '1'  # cpplint doesn't provide column numbers
                    # Extract error type from the part before parentheses
                    error_type_match = re.match(r'([^\(]+)', name)
                    error_type = error_type_match.group(1).strip() if error_type_match else ''
                else:
                    # Fallback if format doesn't match
                    filepath = name
                    line = '1'
                    col = '1'
                    error_type = ''
            else:
                # clang-tidy format: "/path/to/file.cpp:line:column"
                match = re.match(r'(.+):(\d+):(\d+)', name)
                if match:
                    filepath, line, col = match.groups()
                else:
                    # Handle format without line:column (e.g., copyright tests)
                    # Default to line 1, column 1
                    filepath = name
                    line = '1'
                    col = '1'
                error_type = ''

            message = failure.get('message', '').split('\n')[0]  # First line only

            # Apply filtering based on include/exclude patterns
            if include_patterns:
                # Only include if message contains ANY of the include patterns
                if not any(pattern in message for pattern in include_patterns):
                    continue

            if exclude_patterns:
                # Exclude if message contains ANY of the exclude patterns
                if any(pattern in message for pattern in exclude_patterns):
                    continue

            if show_stats:
                # Extract error type from square brackets in message or from name
                if is_cpplint and error_type:
                    # For cpplint, use the error type from the name
                    error_type_clean = re.sub(r'\s*\[\d+\]\s*$', '', error_type).strip()
                    error_types[error_type_clean] += 1
                else:
                    # For clang-tidy and others, extract from square brackets in message
                    error_type_match = re.search(r'\[([^\]]+)\]', message)
                    if error_type_match:
                        error_type = error_type_match.group(1)
                        error_types[error_type] += 1
                    else:
                        # No error type found, use generic label
                        error_types['<no-type>'] += 1
            else:
                # Quickfix format: filepath:line:col: message
                print(f"{filepath}:{line}:{col}: {message}")

    if show_stats:
        print_statistics(error_types)

def print_statistics(error_types):
    """Print statistics about error types."""
    if not error_types:
        print("No errors found.")
        return

    total = sum(error_types.values())
    print(f"Total errors: {total}\n")
    print(f"{'Count':<8} {'Error Type'}")
    print(f"{'-' * 8} {'-' * 60}")

    # Sort by count (descending), then by name
    for error_type, count in sorted(error_types.items(), key=lambda x: (-x[1], x[0])):
        percentage = (count / total) * 100
        print(f"{count:<8} {error_type} ({percentage:.1f}%)")

def main():
    parser = argparse.ArgumentParser(
        description='Convert xunit XML test results to quickfix format for Vim/Neovim',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  # Basic usage
  %(prog)s clang_tidy.xunit.xml

  # Show statistics of error types
  %(prog)s --stats clang_tidy.xunit.xml

  # Exclude all identifier-length warnings
  %(prog)s --exclude-lints=identifier-length clang_tidy.xunit.xml

  # Exclude multiple lint types (comma-separated)
  %(prog)s --exclude-lints=complexity,length clang_tidy.xunit.xml

  # Only show modernize warnings
  %(prog)s --include-lints=modernize clang_tidy.xunit.xml

  # Include multiple lint types
  %(prog)s --include-lints=modernize,bugprone clang_tidy.xunit.xml

  # Exclude magic numbers but include other readability warnings
  %(prog)s --include-lints=readability --exclude-lints=magic-numbers clang_tidy.xunit.xml

  # Show stats for readability warnings only
  %(prog)s --stats --include-lints=readability clang_tidy.xunit.xml
        '''
    )

    parser.add_argument(
        'xml_file',
        help='Path to xunit XML file to parse'
    )

    parser.add_argument(
        '--include-lints',
        metavar='PATTERN',
        help='Only include lints whose failure message contains PATTERN (comma-separated for multiple)'
    )

    parser.add_argument(
        '--exclude-lints',
        metavar='PATTERN',
        help='Exclude lints whose failure message contains PATTERN (comma-separated for multiple)'
    )

    parser.add_argument(
        '--stats',
        action='store_true',
        help='Show statistics of error types instead of quickfix output'
    )

    args = parser.parse_args()

    # Parse comma-separated patterns into lists
    include_patterns = None
    if args.include_lints:
        include_patterns = [p.strip() for p in args.include_lints.split(',')]

    exclude_patterns = None
    if args.exclude_lints:
        exclude_patterns = [p.strip() for p in args.exclude_lints.split(',')]

    try:
        parse_xunit_to_quickfix(args.xml_file, include_patterns, exclude_patterns, args.stats)
    except FileNotFoundError:
        print(f"Error: File '{args.xml_file}' not found", file=sys.stderr)
        sys.exit(1)
    except ET.ParseError as e:
        print(f"Error: Failed to parse XML file: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()
