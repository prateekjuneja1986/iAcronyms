# iAcronyms
iAcronyms will show the list of fullforms for abbreviation searched by user.

iAcronyms is a sample iOS App developed in order to utilize the public APIs for Full Form definations and display a list of all Full Forms associated with searched abbreviation. 

Technical Specification:
- Project is developed in Xcode 14.2 and Deploymemt Target is iOS 15.0.

Use cases:
- To display list of fullforms for abbreviation searched by user.

APIs integrated(Public APIs):
- http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=team

Licenses and credit details:
- http://www.nactem.ac.uk/software/acromine/rest.html

Project Architectural Details:
- This application follows MVVM architecture with Protocol Oriented Programming(POP).
- APIClient/ NetworkClient is written to handle the network calls.
- Search module has different layes as per MVVM architecture.
- Data binding is done using native Combine framework using property observers. 
- Module level API Service layer is also written in order to segregate the load and to introduce scope of test cases.
- Mock API service is also used to mock the success/ failure scenarios.
- Test cases are also written and executed.
- ViewModel layer test cases are done with mock responses and mock errors.


ScreenShots:

![Simulator Screen Shot - iPhone 14 Pro - 2023-01-30 at 00 59 19](https://user-images.githubusercontent.com/64911146/215353599-89bb4a28-6890-4daa-abe0-aa0fb81535a8.png)


![Simulator Screen Shot - iPhone 14 Pro - 2023-01-30 at 00 41 08](https://user-images.githubusercontent.com/64911146/215353607-090286d7-1e4d-4252-8e7c-22cdf1e3f34c.png)






