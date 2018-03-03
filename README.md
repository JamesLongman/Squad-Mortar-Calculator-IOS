![alt text](https://i.imgur.com/e0Hxbwp.png)

# Squad-Mortar-Calculator-IOS
IOS App: Mortar calculator for the video game Squad

There are a few websites out there with mortar calculators and even an android app but unfortunately there was no IOS app and many
people including myself wanted one so here it is! This is the first IOS app I have made and my first time using Swift or
Xcode so contributions are definitely welcome there is certainly a lot that can be improved on I am sure.

## How it works

Unfortunately there are no readily available 3d mapping of Squad maps so the formula that this and as far as I know all calculators use
is based on an interpolation of the provided figures for a 2d plane. There are many ways to accurately accomplish this interpolation and
I have taken the simple method of using a 12th order polynomial calculated by polynomial regression. The formula was calculated by
[PolySolve](http://www.arachnoid.com/polysolve) and provides a correlation coefficient of 0.9999994.

Fortunately user error is a far greater problem than error due to altitude differences as at all but extreme ranges mortars fall extremely
steeply mitigating the error. The formula itself is accurate to about ±1 meter on a 2D plane, a value far smaller than the natural spread
of mortars.

The app calculates 3 values: Distance, Azimuth, and Milliradians. Firstly the app accepts input for grids of the form (A1-1-1) and converts
these grids into meters in the game's own coordinate system. The app also accepts subgrid input which has an effective accuracy of 1 pixel
on the user's screen.

After both the Mortar and Target positions are accepted and converted to meters in the XY plane, the distance and azimuth are found
by simple trigonometry. The milliradian value is then calculated from the meter value using the formula discussed previously. The precise
formula used for those interested is:
>
    func rads(distance: Double) -> Double {
        var rads:Double = 1603.9273942850821 // const from polynomial
        rads += -5.8438295306148713 * pow(10, -1) * distance
        rads += 2.3978428325334847 * pow(10, -3) * pow(distance, 2)
        rads += -1.6710022368637173 * pow(10, -5) * pow(distance, 3)
        rads += 6.8176342659639214 * pow(10, -8) * pow(distance, 4)
        rads += -1.7561870164951840 * pow(10, -10) * pow(distance, 5)
        rads += 2.7973321639240712 * pow(10, -13) * pow(distance, 6)
        rads += -2.2893211828988827 * pow(10, -16) * pow(distance, 7)
        rads += -2.7848767129442064 * pow(10, -20) * pow(distance, 8)
        rads += 2.7355539358279937 * pow(10, -22) * pow(distance, 9)
        rads += -2.8038885580479877 * pow(10, -25) * pow(distance, 10)
        rads += 1.2940370170642232 * pow(10, -28) * pow(distance, 11)
        rads += -2.3669421263783761 * pow(10, -32) * pow(distance, 12)

        return rads
    }
    
## Contribution Guidelines

Thank you for considering contributing to the project, I am very much a beginner when it comes to swift so feedback and pull requests are
very much welcome. To report a bug or suggest a new feature simply open a new issue after making a
quick search to check a duplicate issue does not already exist.

For code contributions please first assign the relevant issue to yourself, then branch off the develop branch and create a PR to merge
your work into the develop branch when you're ready. Comments on issues and pull requests are also very much welcome.

Please leave comments on any code that isn't immediately obvious, tests aren't required as the entire project needs them currently.

The master branch is the current release and the develop branch is the next release.