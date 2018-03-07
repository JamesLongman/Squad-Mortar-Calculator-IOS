<img src="https://i.imgur.com/e0Hxbwp.png" align="right" />

Thank you for considering contributing to the project, I am very much a beginner when it comes to swift so feedback and pull requests are
very much welcome. 

## Bug Reports/Feature Requests
To report a bug or suggest a new feature simply open a new issue after making a
quick search to check a duplicate issue does not already exist.

## Code Contributions Guidelines For Developers
Code contributions are very welcome, the following is a guide to assist in any contributions you may wish to make.

The project was built using:
Xcode 9.2
Swift 4.1

### Workflow
The project is developed in the 'develop' branch, the next release is built in this branch and merged with master when submitted to the app store for release/review. Work is merged into the develop branch with the following workflow:
- Firstly an issue is created to track the work that needs to be done and who is currently doing it. The issue is given a priority/status and possible assign to a milestone marking which release it will likely be included in.
- Next the issue is assigned, feel free to comment on any open issue with the status: "Pending Assignment" stating you intend to attempt to tackle it
- Work is then carried out on a feature branch, forking is not required but personal preference
- After the work is complete in a feature branch a PR may be opened to merge the work into the develop branch, the code will be automatically reviewed for style by Codacy and tests will be ran by Travis, these tests must pass
- Once work passes automated review, manual review will be required (feel free to assist in code review by commenting on code in any open PRs)
- If no changes are required the issues branch is then merged into the develop branch, the issue is then marked completed and kept open until the next release

### Code requirements
- Please leave comments on any code that isn't immediately obvious
- Tests are not required for all swift files, if it can be tested it should be tested with as high coverage as possible and as robustly as appropirate. If you happen to write some swift code but are unable to write tests for it simply request help with the PR
- The project conforms to the recommended style guide by tailor. Codacy will automatically comment on PRs if style changes are required

### Linter
As previously mentioned the project conforms to a style guide powered by tailor; Codacy will automatically comment on your PRs if changes are required but the lintor can be run automatically in Xcode to ease conformation, if you wish to accomplish this instructions on tailer xcode intergration is available [here](https://github.com/sleekbyte/tailor)
