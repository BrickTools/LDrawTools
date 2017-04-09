# LDrawTools

LDrawTools is a Swift Package that includes command line tools to list LDraw parts and colors. It includes ``LDPartList`` and ``LDColorList``.

## Building from Source

```
$ git clone https://github.com/ornithocoder/LDrawTools.git
$ cd LDrawTools
$ swift build
```

## LDPartList

Simple LDPartList implementation in Swift - with JSON support - to create a list of [LDraw parts](http://www.ldraw.org/parts/latest-parts.html).

### Using it

Copy the LDPartList binary to LDraw's root directory before running it or use the ``--ldraw`` option to specify LDraw's root directory.

```
$ LDPartList -h
Usage: LDPartList [options]

Options:
-d        Sort by description
-n        Sort by file name
-m        Ignore parts that moved (~ Moved to...)
-~        Ignore parts that start with tilde (~)
-_        Ignore parts that start with _
-=        Ignore parts that start with =
--type    Output format: either json or list
--filter  Filter out parts that don't contain the specified word (case-insensitive)
--ldraw   Set the LDraw path
-h        Show this help
```

### Examples

Sorting by file name and ignoring parts that moved and parts that start with ``~``, ``_``, and ``=``.

```
$ LDPartList -n -m -~ -_ -=
003238a.dat                Sticker Minifig Shield Triangular with Crown on DkPink B/ground
003238b.dat                Sticker Minifig Shield Triangular with Green Chevrons on DkGray
003238c.dat                Sticker Minifig Shield Triangular with White Maltese Cross
003238d.dat                Sticker Minifig Shield Triangular with Yellow Trefoils on Blue
003238e.dat                Sticker Minifig Vest with Crown on Dark Pink Background
003238f.dat                Sticker Minifig Vest with Shield with Green Chevrons/DkGray
003238g.dat                Sticker Minifig Vest w/ Shield with White Maltese Cross/DkGray
003238h.dat                Sticker Minifig Vest with Yellow Trefoils on Blue Background
003238i.dat                Sticker Flag with Crown on Dark-Pink
...
```

Sorting by description and ignoring parts that moved and parts that start with ``~``, ``_``, and ``=``.

```
$ LDPartList -d -m -~ -_ -=
30103.dat                  Animal Bat
13665.dat                  Animal Bird Crow
2546.dat                   Animal Bird Parrot
2546p02.dat                Animal Bird Parrot with Blended Green Wings and Tail Pattern
11091.dat                  Animal Bird Wing 9L with Stylized Feathers
2546p01.dat                Animal Bird with Parrot Pattern
6251.dat                   Animal Cat Crouching
87695.dat                  Animal Cattlehorns
95342.dat                  Animal Chicken
...
```

Exporting list of parts as JSON, sorting by description and ignoring parts that moved and parts that start with ``~``, ``_``, and ``=``.

```
$ LDPartList --type json -d -m -= -~ -_
[
  {
    "description" : "Animal Bat",
    "fileName" : "30103.dat"
  },
  {
    "description" : "Animal Bird Crow",
    "fileName" : "13665.dat"
  },
  {
    "description" : "Animal Bird Parrot",
    "fileName" : "2546.dat"
  },
  {
    "description" : "Animal Bird Parrot with Blended Green Wings and Tail Pattern",
    "fileName" : "2546p02.dat"
  },
  {
    "description" : "Animal Bird Wing 9L with Stylized Feathers",
    "fileName" : "11091.dat"
...
```

Redirecting the output to file

```
$ LDPartList -d -m -~ -_ -= > parts.lst               # save as list
$ LDPartList -d -m --type json -~ -_ -= > parts.json  # save as JSON
```

## LDColorList

Creates a list of [LDraw colors](http://www.ldraw.org/article/547.html).

### Using it

Copy the LDColorList binary to LDraw's root directory before running it or use the ``--ldraw`` option to specify LDraw's root directory.

```
$ LDColorList -h
Usage: LDColorList [options]

Options:
-d        Sort by description
-c        Sort by code
--type    Output format: json or list
--filter  Filter out colors that don't contain the specified word (case-insensitive)
--ldraw   Set the LDraw path
-h        Show this help
```

### Examples

Sorting colors by description.

```
$ LDColorList -d
118       Aqua
0         Black
1         Blue
89        Blue Violet
10        Bright Green
212       Bright Light Blue
191       Bright Light Orange
226       Bright Light Yellow
29        Bright Pink
6         Brown
...
```

Exporting colors as JSON.

```
$ LDColorList --type json
[
  {
    "name" : "Black",
    "value" : "#05131D",
    "alpha" : null,
    "luminance" : null,
    "code" : 0,
    "edge" : "#595959"
  },
  {
    "name" : "Blue",
    "value" : "#0055BF",
    "alpha" : null,
    "luminance" : null,
    "code" : 1,
    "edge" : "#333333"
  },
  {
    "name" : "Green",
    "value" : "#257A3E",
...
```

Redirecting the output to file

```
$ LDColorList -c > colors.lst               # save as list
$ LDColorList -d --type json > colors.json  # save as JSON
```

# License

Copyright (c) 2017 Ornithologist Coder. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
