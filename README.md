# SliMath
Evaluate algebraic expression (can define variables x, y and z) and plot functions, parametric and polar equations. Written in Turbo Delphi, based on TExpressionParser.

I started project as an attempt to create my ideal Windows calculator. I don't like software calculators that simulate a keyboard with controls/buttons (what's the point if you don't get the tactile feedback), so on a computer I prefer to type and evaluate expressions.
Unfortunately, although I was unsatisfied with other products I tried, I was never able to properly define an exhaustive wish list and/or how to implement my requirements in both an elegant and user friendly way. I did implement most (if not all) of my original ideas, but I quickly ran out of ideas for new features or improvements.
At work, I mostly do calculations in Excel (no comments!), while at home (and at work for calculations that do not need saving), I mostly use my HP48SX as I like to punch on the keyboard.
As a result, this project has been in limbo for almost 2 years now, and since I have no plan to work on it any further, I'm just releasing it as it. Maybe I just wanted to prove to myself that I could do it rather than have a genuine incentive to create a complete product, as I've never found the motivation to go back to it.
If someone can help contribute not just in code but also in ideas, feel free to do so. Of course, you can fork your own branch, and I'm open to merging contributions.

Current features:

    Can work with 3 variable (x, y and z). See screenshot 1.
    Call a previous results by clicking on it in the history.
    Call the latest result by pressing the "Insert" key (e.g. like "Ans" on calculators).
    Evaluate expressions including variables and many mathematical functions (e.g. trigonometric, exponential/power/logarithmic, min/max, etc).
    Saves your scratchpad on exit and loads it on launch, but can also clear/save/load on demand.
    Can plot up to 10 functions (including polar and parametric, the variable is x no matter the type, see screenshot 2).
    Can customise all graphs aspects (axes, ticks, colours, etc).
    Can save graphs to PNG.
