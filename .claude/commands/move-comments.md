---
description: Move inline comments to above the line for method declarations and member variables
---

You are tasked with restructuring C++ code to move inline comments above their associated declarations for better readability with clang-format.

Target: $ARGUMENTS

## Transformation Rules

### For Method Declarations:
Convert inline parameter comments to above-method comments with format `// param_name: description`

**Before:**
```cpp
void MyMethod(
  int param1,  // description of param1
  const std::string & param2,  // description of param2
  double param3);  // description of param3
```

**After:**
```cpp
// param1: description of param1
// param2: description of param2
// param3: description of param3
void MyMethod(
  int param1, const std::string & param2, double param3);
```

### For Member Variables:
Move inline comments to the line above the variable declaration.

**Before:**
```cpp
bool flag_;  // description of flag
int count;   // description of count
double
  value_;  // description of value across
           // multiple lines
```

**After:**
```cpp
// description of flag
bool flag_;
// description of count
int count;
// description of value across multiple lines
double value_;
```

## Special Cases:
- Preserve multi-line comments by combining them into a single above-line comment
- Keep section comments (like `/// Section Name`) unchanged
- Maintain proper indentation for comments
- Handle comments that span multiple lines due to line wrapping
- Preserve existing above-line comments that don't need transformation

## Instructions:
1. If $ARGUMENTS is a directory, find all .h and .cpp files recursively and apply transformations
2. If $ARGUMENTS is a file, apply transformations to that file only
3. Read each file completely before making edits
4. Apply transformations systematically, preserving all other formatting
5. Do not modify code logic, only comment positioning
6. Confirm completion with a summary of files modified

Begin the transformation process now.
