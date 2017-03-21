# LDMakeList

Simple LDMakeList implementation in Swift with JSON support.

## Building from Source

```
$ git clone https://github.com/ornithocoder/LDMakeList.git
$ cd LDMakeList
$ swift build
```

## Using it

Copy the LDMakeList binary to LDraw's root directory before running it.

```
$ LDMakeList -h
USAGE: LDMakeList [options]

OPTIONS:
  -d	Sort by description
  -n	Sort by file name
  -m	Ignore parts that moved (~ Moved to...)
  -~	Ignore parts that start with tilde (~)
  -_	Ignore parts that start with _
  -=	Ignore parts that start with =
  -j	Print as JSON
  -h/-?	Show this help
```

### Examples

Sorting by file name (n) and ignoring parts that moved and parts that start with ~, _, and =.

```
$ LDMakeList -n -m -~ -_ -= | head
003238a.dat                Sticker Minifig Shield Triangular with Crown on DkPink B/ground
003238b.dat                Sticker Minifig Shield Triangular with Green Chevrons on DkGray
003238c.dat                Sticker Minifig Shield Triangular with White Maltese Cross
003238d.dat                Sticker Minifig Shield Triangular with Yellow Trefoils on Blue
003238e.dat                Sticker Minifig Vest with Crown on Dark Pink Background
003238f.dat                Sticker Minifig Vest with Shield with Green Chevrons/DkGray
003238g.dat                Sticker Minifig Vest w/ Shield with White Maltese Cross/DkGray
003238h.dat                Sticker Minifig Vest with Yellow Trefoils on Blue Background
003238i.dat                Sticker Flag with Crown on Dark-Pink
```

Sorting by description (d) and ignoring parts that moved and parts that start with ~, _, and =.

```
$ LDMakeList -d -m -~ -_ -= | head
30103.dat                  Animal Bat
13665.dat                  Animal Bird Crow
2546.dat                   Animal Bird Parrot
2546p02.dat                Animal Bird Parrot with Blended Green Wings and Tail Pattern
11091.dat                  Animal Bird Wing 9L with Stylized Feathers
2546p01.dat                Animal Bird with Parrot Pattern
6251.dat                   Animal Cat Crouching
87695.dat                  Animal Cattlehorns
95342.dat                  Animal Chicken
```

Exporting list of parts as JSON, sorting by description (d) and ignoring parts that moved and parts that start with ~, _, and =.

```
$ LDMakeList -j -d -m -= -~ -_ | head -n 20
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
```

Redirecting the output to file

```
$ LDMakeList -d -m -~ -_ -= > parts.lst       # save as text
$ LDMakeList -d -m -j -~ -_ -= > parts.json   # save as JSON
```
