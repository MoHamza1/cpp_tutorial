# How to build.
buildit.sh will build the program and shared object for you.. the confiuration will be 64 bit Debugable.
alternatively:

``` bash
cd shared_object_example
make debug64 | release64 | debug32 | release32 ### Choose one of these, don't be dumb and copy the whole line..
cd ..
make debug64 | release64 | debug32 | release32 ### Choose the same one you picked above..
```
TODO: learn how to use Cmake.
TODO: Use the shared object makefile as a dependent component for the base directory makefile. 
TODO: portable makefile that can also build for windows.
TODO: establish a propper dependency graph, kind-of like how package.json works with npm.
TODO: Find out how that (super super cool) github CI sticker works for build statuses.
TODO: find out how to release binaries and digitally sign them. (for various linux distros and windows versions)
TODO: find out how to create a documentation server.

# How to Debug with VSCODE and gdb.

1. See the section on how to build.
2. set a breakpoint anywhere in the expected execution path.
3. click run and debug in the left tab, then click the play button.

# A basic C++ program that builds with a statically linked library.
OOP in c++ is a somewhat open ended topic. 
On one hand, you have quite a lot of creative freedom; 
- This in the sense that you can define your classes in their implementation (bad), you can have big fat monolithic source files that take centuries to build (worse)....
- Or you can be transparent and define your class heirarchy with inteligence (usually in one or moreheader files) and Include them later when you build (requires annoying IDE setup if you need intelisense).

And on the other hand, your OOP setup can be quite esoteric involving Interfaces and the relevant factories, and so on.

Developers who have grappeled with hideous code bases (usually the same people responsible for their existence) could work for centuries simplifying their work for posterity. But the trade off of... Implement this feature now, or refactor the hell out of existitng code.

## Possible points of discussion and solutions to explore in order to alleviate them:
### ... I write for comedic effect and because I wan't to get better and analyse this imperically.

- Time is money 
    - (don't waste it), 
- refactoring is boring 
    - (always be introspective and learn improve), 
- build systems are tedious 
    - (but extremely important), 
- IDE's don't like hideously complicated build structures 
    - (suppose there are tonnes of shared libraries all in seperate revision controls repos).. spend a bit of time improving your work flow, you may end up with a better understanding of your surroundings.
- You have to spend time configuring your development environment.. and `<insert deity of choice>` help you when you have to do the same when shipping binaries.
    - (release engineering and )
- Testing is an afterthought that seems irrelevant when you feel compelled to write functioning code in the first place.
    - So be smart with testing.. either get so good at it that you're writing unit tests as you go.. instead of flailing around googling how to fix your null pointer issues
- c++ isn't particularly at fault for any of this madness.
    - It's all about getting better at doing your job.. 
    - some people love using gdb on the command line, vim for development, and iteractive rebasing.
    - I actively avoided most of these things, and slowly coming around to actually becoming better.
- Scripting is overkill.
    - scripting is not overkill.. 
    - I need a deaper understanding over the syntax of shell and batch scripts.
    - They are unneccessarily obtuse and esoteric.. I hate them.. but they make life so much easier.