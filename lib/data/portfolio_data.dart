import 'package:flutter/material.dart';
import '../models/experience.dart';
import '../models/Recommendation.dart';

class PortfolioData {
  static final List<Experience> experiences = [
    Experience(
      title: "Freelancer",
      company: "",
      duration: "Dec 2021 - Present",
      location: "Bengaluru · Remote",
      type: "",
      skills: ["Flutter", "Swift", "SwiftUI", "Firebase", "Google Maps", "OpenStreetMaps", "Razorpay", "Google AdMob"],
      icon: Container(),
    ),
    Experience(
      title: "Lead Mobile Developer",
      company: "Isoftcell",
      duration: "Dec 2019 - Dec 2021",
      location: "Bengaluru",
      type: "Full Time",
      skills: ["Flutter", "Swift", "Firebase", "Google Maps", "Razorpay"],
      icon: Image.asset("assets/images/isoftcell.png"),
    ),
    Experience(
      title: "iOS Developer",
      company: "RIOT Infomedia",
      duration: "Sep 2018 - Nov 2019",
      location: "Chennai",
      type: "Full time",
      skills: ["Swift", "Firebase"],
      icon: Image.asset("assets/images/riot.png"),
    ),
    Experience(
      title: "Software Engineer",
      company: "Buffer Code",
      duration: "Dec 2017 - June 2018",
      location: "Chennai",
      type: "Full Time",
      skills: ["Swift", "Firebase"],
      icon: Image.asset("assets/images/buffercode.png"),
    ),
    Experience(
      title: "Creative Technologist",
      company: "Made By Fire  Pvt Ltd.",
      duration: "Nov 2016 - Dec 2017",
      location: "Chennai",
      type: "Full Time",
      skills: ["Swift", "Firebase", "Google Maps"],
      icon: Image.asset("assets/images/madeByfire.png"),
    ),
    Experience(
      title: "Software Engineer",
      company: "Pickzy Interactive Pvt Ltd.",
      duration: "Oct 2014 - Oct 2016",
      location: "Chennai",
      type: "Full Time",
      skills: ["Objective C", "Swift", "Firebase"],
      icon: Image.asset("assets/images/pickzy.png"),
    ),
    Experience(
      title: "Software Engineer",
      company: "Coasian Info Tech",
      duration: "May 2013 - Aug 2014",
      location: "Chennai",
      type: "Full Time",
      skills: ["Objective C", "Firebase"],
      icon: Image.asset("assets/images/coasian.png"),
    ),
  ];

  static final List<Recommendation> demoRecommendations = [
    Recommendation(
      name: "Kolapo Obanewa",
      source: "Linkedin",
      text:
          "I have had the pleasure of working with Anwar on two flutter projects and what strikes me the most about his work is his ability to write clean and reusable codes with best practices. He is hardworking and makes it so easy to transcribe ideas into beautiful and testable flutter apps. He is a Flutter/Dart gem and has my highest recommendation",
    ),
    Recommendation(
      name: "Reza Shahbazi",
      source: "Linkedin",
      text:
          "Abu is great asset for any organization. It's a true pleasure working with him at TakeIn. His flutter skill is amazing as well as his professionalism and being a good team player. Abu's problem solving skill is also one of his great skills.",
    ),
    Recommendation(
      name: "Diadem",
      source: "YouTube",
      text:
          "I like your way you doing your project and you taught us. After I watch this I like and hit the subscribe button and then watch your video playlist one by one!! Within three hours, I learned a lot! I share your channel in my college WhatsApp group!",
    ),
    Recommendation(
      name: "Roshan Shetty",
      source: "YouTube",
      text:
          "Very straightforward, professional and also the best flutter videos in the youtube! It will be great if you add some comments to your steps with 0.5 seconds pause before implementing this step. By meaning of steps, I mean not the basic, but structural steps, like 10-20 steps per video. However, thank you very much!",
    ),
  ];

  /*
  ═════════════════════════════════════════════════════════════════════════════
  📖 NARRATIVE CONTENT BLOCK REFERENCE GUIDE
  ═════════════════════════════════════════════════════════════════════════════
  Any narrative section ("challenge", "solution", "myRole", "backstory",
  "approach", "keyOutcomes", "whatMakesThisDifferent", "whatITookFromIt")
  can be formatted in 3 ways:

  1. Simple String (Legacy):
     "myRole": "Lead Developer tasked with building..."

  2. Simple Array of Strings:
     "myRole": [
       "First point item...",
       "Second point item..."
     ]

  3. Rich Mixed Block List (Supports All 5 Block Types Below):
     "challenge": [
       // TYPE 1: HEADING BLOCK (Large Bold Section Sub-Heading)
       {
         "type": "heading",
         "text": "Simplifying complex data for everyday investors."
       },

       // TYPE 2: PARAGRAPH BLOCK (Regular Text Paragraph)
       {
         "type": "paragraph",
         "text": "The legacy platform suffered from information overload..."
       },

       // TYPE 3: POINTS / BULLETS BLOCK
       // Icon styles available: "number" (1., 2.), "dash" (—), "check" (✓), "bullet" (•), "target" (🎯), "star" (⭐)
       {
         "type": "points",
         "iconStyle": "dash",
         "items": [
           "High friction in KYC and account creation (avg 15 mins).",
           "Lack of transparency in loan origination status."
         ]
       },

       // TYPE 4: SINGLE IMAGE BLOCK (With optional caption)
       {
         "type": "image",
         "url": "assets/images/mhb.png",
         "caption": "Revised onboarding and loan status dashboard UI"
       },

       // TYPE 5: MULTIPLE IMAGES / GALLERY BLOCK (With optional caption)
       {
         "type": "images",
         "urls": [
           "assets/images/mhb.png",
           "https://picsum.photos/800/450?1"
         ],
         "caption": "Before and after comparison screens"
       },

       // TYPE 6: VIDEO BLOCK (With optional caption)
       {
         "type": "video",
         "url": "assets/videos/demo.mp4",
         "caption": "Interactive video walkthrough demo"
       }
     ],

  4. Engineering Challenges List (Rendered before Media & Gallery):
     "engineeringChallenges": [
       {
         "number": "01",
         "title": "Offline-First Synchronization",
         "problem": "Field agents in remote regions experienced network dropouts...",
         "approach": "Implemented local SQLite DB with custom sync engine...",
         "code": "const syncData = async () => { ... };",
         "codeLanguage": "javascript" // or "swift", "dart", "kotlin"
         // Alternatively, use "image": "assets/images/architecture.png"
       }
     ]
  ═════════════════════════════════════════════════════════════════════════════

  Gallery bezel option (per project):
  - Set "mediaHasBezel": true when every gallery image already includes its
    own device bezel/mockup. The gallery and full-screen preview will not add
    a second default device frame.
  - Omit it, or set it to false, to use the default platform frame.
  */
  static const List<Map<String, dynamic>> projectsJson = [
    {
      "title": "Richie Rich IceCreams",
      "description": """Hungry? Craving something cold, creamy, or crunchy?
With richie_rich Icecreams, you can order a wide range of ice creams, sundaes, snacks, and quick bites delivered straight to your doorstep or ready for takeaway.

Features:
Browse delicious ice creams, sundaes, and shakes
Order snacks and fast bites anytime
Easy takeaway and doorstep delivery
Smooth app experience for quick ordering.""",
      "image": "assets/images/richie_rich/richie_rich.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": ["Flutter", "Firebase", "REST API", "RazorPay"],
      "github": null,
      "playStore":
          "https://play.google.com/store/apps/details?id=com.richierichicecreams.resturent_app&pcampaignid=web_share",
      "appStore":
          "https://apps.apple.com/in/app/richie-rich-icecreams/id6563153090",
      "year": "2026",
      "role": "Freelancer",
      "projectType": "Mobile App",
      "backstory":
          "Richie Rich was an existing Flutter-based restaurant application that required significant technical and functional improvements. The application had multiple UI issues, push notification problems, API-related bugs, outdated platform configurations, and a poorly structured codebase without a clear architectural pattern. The project focused on stabilizing the existing application, improving its maintainability, upgrading the technology stack, and preparing reliable builds for both Android and iOS.",
      "myRole": [
        {
          "type": "points",
          "iconStyle": "bullet",
          "items": [
            "Worked as the Flutter developer responsible for debugging and improving the existing application.",
            "Fixed UI design, API, and push notification issues.",
            "Refactored the existing codebase and introduced a structured architecture.",
            "Implemented MVVM and SOLID principles.",
            "Improved code organization to make debugging and maintenance easier.",
            "Upgraded Flutter and updated Android/iOS configurations.",
            "Completed iOS certificates and provisioning profile setup.",
            "Generated production builds and handled store uploads.",
          ]
        }
      ],
      "challenge":
          "The major challenge was working with an existing codebase that had poor structure, no consistent architectural pattern, and difficult-to-maintain code. Debugging was complicated because of the way the code was organized. In addition, the application had multiple UI, API, and push notification issues, while its Flutter and Android/iOS configurations required upgrading to work correctly with newer platform requirements.",
      "approach": [
        {
          "type": "points",
          "iconStyle": "bullet",
          "items": [
            "First analyzed and fixed the existing UI, API, and push notification issues.",
            "Refactored the existing code instead of rebuilding the application from scratch.",
            "Introduced MVVM architecture for better separation of responsibilities.",
            "Applied SOLID principles to improve code maintainability.",
            "Used Riverpod for state management.",
            "Reduced overly large code sections and organized functionality into smaller, easier-to-debug units.",
            "Upgraded Flutter to the latest required version.",
            "Updated Android and iOS configurations to support the upgraded Flutter version."
          ]
        }
      ],
      "solution":
          "The application was transformed from a difficult-to-maintain codebase into a more structured Flutter application with MVVM-based architecture, SOLID-oriented code organization, and Riverpod state management. Existing UI, API, and push notification problems were fixed, the Flutter and native platform configurations were upgraded, and the application was prepared for production distribution. I also handled the iOS signing requirements by creating certificates and provisioning profiles, generating production builds, and publishing the application to both stores.",
      "keyOutcomes": [
        {
          "type": "points",
          "iconStyle": "bullet",
          "items": [
            "Resolved multiple existing UI, API, and push notification issues.",
            "Improved the maintainability and readability of the existing Flutter codebase.",
            "Introduced MVVM architecture and SOLID principles.",
            "Implemented Riverpod for structured state management.",
            "Upgraded the Flutter project and updated Android/iOS configurations.",
            "Prepared production-ready Android and iOS builds.",
            "Completed iOS certificates and provisioning profile setup.",
            "Successfully generated and uploaded builds to the relevant app stores.",
          ]
        }
      ],
      "whatMakesThisDifferent":
          "The key differentiator was not simply developing new features, but taking an existing poorly structured production application and improving it without starting the project from scratch. The work involved debugging legacy implementation issues, introducing a proper architecture, modernizing the Flutter and native configurations, and taking responsibility for the complete path from code stabilization to store deployment.",
      "whatITookFromIt":
          "This project strengthened my experience in Flutter codebase refactoring, MVVM architecture, SOLID principles, Riverpod state management, API debugging, push notification troubleshooting, and Flutter version migration. It also gave me practical experience with the iOS release ecosystem, including Apple certificates, provisioning profiles, production builds, signing, and App Store deployment, while reinforcing the importance of maintainable architecture when working with an existing production codebase."
    },
    {
      "title": "All Calculator: EMI, SIP, GST",
      "description":
          """Ultimate All-In-One Calculator: Simple, Scientific & Financial Tool

Tired of switching between different apps for math, loans, and health? All Calculator is the only tool you’ll ever need! Designed with a stunning, modern Neumorphic UI, our app provides a premium, lag-free experience for students, professionals, and financial planners.

""",
      "image": "assets/images/all_calculator/all_calculator.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": [
        "Flutter",
        "Firebase",
        "Remote Config",
        "REST API",
        "Google AdMob"
      ],
      "github": null,
      "playStore":
          "https://play.google.com/store/apps/details?id=app.smartcalcstudio.calc",
      "appStore": null,
      "year": "2025",
      "role": "Freelancer",
      "projectType": "Mobile App",
      "myRole": [
        {
          "type": "points",
          "iconStyle": "bullet",
          "items": [
            "Worked as the Flutter developer responsible for developing the application from scratch.",
            "Implemented MVVM and SOLID principles.",
            "Improved code organization to make debugging and maintenance easier.",
            "Generated production builds and handled store uploads.",
          ]
        }
      ],
    },
    {
      "title": "ParkingSthal",
      "description":
          """Parking Sthal helps you find and book nearby parking spaces with ease. Discover available
spots around you, check timings, and make secure payments through the app. Whether for
malls, offices, or events, Parking Sthal makes parking simple, fast, and convenient for every
driver and space owner.
""",
      "image": "assets/images/parking_sthal/parking_sthal.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": [
        "Flutter",
        "Firebase",
        "REST API",
        "Push Notifications",
        "Google Maps",
        "Razor Pay"
      ],
      "github": null,
      "playStore":
          "https://play.google.com/store/apps/details?id=com.app.parking_sthal&hl=en_IN",
      "appStore": null,
      "year": "2025",
      "role": "Freelancer",
      "projectType": "Mobile App",
      "myRole": [
        {
          "type": "points",
          "iconStyle": "bullet",
          "items": [
            "Worked as the Flutter developer responsible for developing the application from scratch.",
            "Implemented MVVM and SOLID principles.",
            "Improved code organization to make debugging and maintenance easier.",
            "Generated production builds and handled store uploads.",
          ]
        }
      ],
    },
    {
      "title": "CallPik",
      "description":
          """Callpik is an communication app where you can talk and provide expert opinion and technical ideas over call. Callpik provides Audio call & Video call option to talk with the Consultants.

Feature of Callpik App:

Simple Signup: Download the Callpik app. Enter the Phone number with Country code. For Phone number verification purpose, enter the received OTP. No need for email and other personal information.

Lanuguage: When signing up, just choose the language you want to connect in. The app will then connect you with users who speak the same language, making communication easy and smooth.

Reliable and Secure: Callpik user can connect any other consultant with audio and video call where they can start a conversation. Discuss about Mindfull Sessions, Mental wellness, Emotional wellness, Stress Management and discuss about all your favourite topics related Wellness.

Blocking Option: Safety is our priority. User can option to block others.

Privacy: Don’t want to reveal your face? Choose an avatar for your profile picture

Note: Our app does not support inappropriate behaviour and takes strict actions against fake profiles.

""",
      "image": "assets/images/call_pik/call_pik.jpg",
      "categories": ["Flutter"],
      "media": [],
      "technologies": [
        "Flutter",
        "Firebase",
        "REST API",
        "Push Notifications",
        "Google Maps",
        "Razor Pay"
      ],
      "github": null,
      "playStore":
          "https://play.google.com/store/apps/details?id=com.callpik.app&hl=en_IN",
      "appStore": null,
      "year": "2024",
      "role": "Freelancer",
      "projectType": "Mobile App",
      "myRole": [
        {
          "type": "points",
          "iconStyle": "bullet",
          "items": [
            "Worked as the Flutter developer responsible for debugging and improving the existing application.",
            "Fixed UI design, API, and push notification issues.",
            "Refactored the existing codebase and introduced a structured architecture.",
            "Implemented MVVM and SOLID principles.",
            "Improved code organization to make debugging and maintenance easier.",
            "Upgraded Flutter and updated Android/iOS configurations.",
            "Completed iOS certificates and provisioning profile setup.",
            "Generated production builds and handled store uploads.",
          ]
        }
      ],
      "challenge":
          "The major challenge was working with an existing codebase that had poor structure, no consistent architectural pattern, and difficult-to-maintain code. Debugging was complicated because of the way the code was organized. In addition, the application had multiple UI, API, and push notification issues, while its Flutter and Android/iOS configurations required upgrading to work correctly with newer platform requirements.",
      "approach": [
        {
          "type": "points",
          "iconStyle": "bullet",
          "items": [
            "First analyzed and fixed the existing UI, API, and push notification issues.",
            "Refactored the existing code instead of rebuilding the application from scratch.",
            "Introduced MVVM architecture for better separation of responsibilities.",
            "Applied SOLID principles to improve code maintainability.",
            "Used Provider for state management.",
            "Reduced overly large code sections and organized functionality into smaller, easier-to-debug units.",
            "Upgraded Flutter to the latest required version.",
            "Updated Android and iOS configurations to support the upgraded Flutter version."
          ]
        }
      ],
      "solution":
          "The application was transformed from a difficult-to-maintain codebase into a more structured Flutter application with MVVM-based architecture, SOLID-oriented code organization, and Provider state management. Existing UI, API, and push notification problems were fixed, the Flutter and native platform configurations were upgraded, and the application was prepared for production distribution. I also handled the iOS signing requirements by creating certificates and provisioning profiles, generating production builds, and publishing the application to both stores.",
    },
    {
      "title": "Cheerish",
      "description":
          """Cheerish is an interactive educational quiz and MCQ platform designed for school students from Grades 1 to 12. The app helps students strengthen their academic foundation through chapter-wise practice tests and comprehensive performance analytics.

Features of Cheerish App:

Seamless Student Access: Students log in effortlessly using their mobile number via OTP verification.

Customized Learning Path: Select grade (1st to 12th standard), choose subjects, and explore chapter-wise quiz modules and mock tests.

Instant Results & Ranking: Get immediate test evaluation with detailed breakdown of correct vs. wrong answers, solution explanations, and test ranks.

Dedicated Parent Portal: Separate login for parents using email ID to track attendance, monitor subject & chapter-wise marks, view rank history, and review overall progress.""",
      "image": "assets/images/cheerish/cheerish.jpg",
      "categories": ["Flutter"],
      "media": [],
      "technologies": [
        "Flutter",
        "Firebase",
        "REST API",
        "Push Notifications",
      ],
      "github": null,
      "playStore": null,
      "appStore": null,
      "year": "2024",
      "role": "Freelancer",
      "projectType": "Mobile App",
    },
   
    {
      "title": "Mwanga Hakika Mobile App",
      "description":
          "MHB mobile app is a comprehensive tool designed to provide MHB users with convenient and secure access to their bank accounts via their smartphones.",
      "image": "assets/images/hakika_banking_app/banking_app.png",
      "categories": ["iPhone", "iPad"],
      "media": [],
      "technologies": ["Swift", "iOS SDK", "REST APIs", "CoreData"],
      "github": null,
      "playStore": null,
      "appStore": null,
      "year": "2023",
      "role": "Lead Designer",
      "projectType": "Web App",
      "pointByPointSections": ["myRole"],
      "backstory":
          "Mwanga Hakika Bank (MHB) needed to transition from traditional branch banking to digital banking. The goal was to provide users with secure and easy access to their bank accounts via their smartphones.",
      "myRole":
          "iOS Lead Developer tasked with architecting the application, implementing secure biometrics authentication.;Core banking API integrations, and designing pixel-perfect screens in SwiftUI.",
      "challenge": [
        {
          "type": "heading",
          "text": "Simplifying complex data for everyday investors."
        },
        {
          "type": "paragraph",
          "text":
              "The legacy platform suffered from information overload. Users struggled to find key portfolio metrics amidst dense tables and cluttered navigation, leading to high drop-off rates during the onboarding process."
        },
        {
          "type": "points",
          "iconStyle": "dash",
          "items": [
            "High friction in KYC and account creation (avg 15 mins).",
            "Lack of transparency in loan origination status."
          ]
        }
      ],
      "approach": [
        {
          "type": "heading",
          "text": "A hierarchical, widget-based dashboard approach."
        },
        {
          "type": "paragraph",
          "text":
              "We introduced a modular architecture allowing users to customize their view. By utilizing progressive disclosure, advanced metrics are tucked away but easily accessible, keeping the primary interface clean and focused."
        }
      ],
      // "engineeringChallenges": [
      //   {
      //     "number": "01",
      //     "title": "Offline-First Synchronization",
      //     "problem":
      //         "Field agents in remote Tanzanian regions frequently experienced network dropouts, leading to data loss during client onboarding and loan origination workflows. A robust queuing mechanism was required to guarantee eventual consistency.",
      //     "approach":
      //         "Implemented a local SQLite database on the mobile client managed via WatermelonDB for reactive data binding. We engineered a custom sync engine utilizing Redux Saga to orchestrate background tasks, intercepting API calls when offline and queueing them for automatic retry upon network reconnection.",
      //     "code":
      //         "const syncData = async () => {\n  try {\n    // 1. Pull remote changes\n    const changes = await fetchRemoteChanges();\n    await database.action(async () => {\n      await applyChanges(changes);\n    });\n\n    // 2. Push local queue\n    const localOps = await getQueuedOperations();\n    if (localOps.length > 0) {\n      await pushToRemote(localOps);\n      await clearLocalQueue();\n    }\n  } catch (error) {\n    Logger.error('Sync failed', error);\n  }\n};",
      //     "codeLanguage": "javascript"
      //   }
      // ],
      "solution": [
        {
          "type": "paragraph",
          "text":
              "We architected a ground-up native mobile application focused on \"ambient trust\"—using clear, large typography, instantaneous micro-interactions, and transparent progress indicators. By restructuring the backend APIs concurrently, we achieved a near-instant UX that felt responsive and secure."
        },
        {
          "type": "points",
          "iconStyle": "check",
          "items": [
            "Automated OCR for instant ID verification (under 2 mins).",
            "Real-time lending dashboard with proactive notifications."
          ]
        }
      ],
      "keyOutcomes":
          "Successfully launched in the App Store, onboarding over 50,000 active banking customers within the first three months of release.",
      "whatMakesThisDifferent":
          "Features localized support, an intuitive dashboard with instant action shortcuts, and offline verification cards for quick account audits.",
      "whatITookFromIt":
          "Gained massive experience in banking transaction security, biometric APIs, Swift encryption libraries, and App Store financial app guidelines."
    },
    {
      "title": "Listen2RE",
      "description":
          "The Audio Learning App that helps you achieve your study goals, your way. No more boring books, no more endless reading - With Listen2RE, you can listen to your favorite books, publications, and current affairs while working out, cooking, or just relaxing. Our platform offers syllabus-specific content, famous publication audiobooks, daily and weekly current affairs updates, and motivational podcasts to help you retain what you learn. Join our community and discover a better way to study",
      "image": "assets/images/listen2re/listen2re.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": ["Flutter", "Firebase", "REST API", "Bloc", "AWS"],
      "github": null,
      "playStore": null,
      "appStore": null,
      "year": "2023",
      "role": "Lead Mobile Developer",
      "projectType": "Audio App",
      "backstory":
          "Listen2RE was conceptualized to address the struggle of students and busy professionals trying to keep up with vast study materials, books, and daily current affairs. The goal was to transform passive travel or chore time into active, productive audio learning.",
      "myRole":
          "Lead Mobile Developer responsible for designing the system architecture, implementing offline audio caching, background playback services, and setting up the Firebase backend integration.",
      "challenge":
          "Handling audio streaming and background audio lifecycle across varying network conditions on Android and iOS devices, ensuring seamless transition between audio states without crashing or losing playback position.",
      "approach":
          "Adopted the Bloc pattern for robust state management. Leveraged AWS Cloudfront for low-latency audio content delivery and implemented custom caching mechanisms using Hive database.",
      "solution":
          "Developed a custom wrapper around the audio service library to handle background audio notification controls, audio ducking, and lock screen media details, integrated with daily motivate podcasts and real-time updates.",
      },
    {
      "title": "Clovemind : Mental Health Care",
      "description":
          "Counselling App to improve mental fitness and well-being.  Feeling anxious, stressed, unhappy or lonely? Unable to effectively process your emotions, thoughts, and feelings? Download Clove Mind online counselling app now for FREE to seek support from trained listeners and therapists anytime, anywhere!",
      "image": "assets/images/clovemind_care/clovemind_care.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": ["Flutter", "Firebase", "Node.js", "Socket.io"],
      "github": null,
      "playStore": "https://play.google.com/store/apps/details?id=com.clovemind.client&pcampaignid=web_share",
      "appStore": "https://apps.apple.com/in/app/clovemind-mental-health-care/id1659711594",
      "year": "2022",
      "role": "Full-stack Developer",
      "projectType": "Mental Health App",
     },
    {
      "title": "Clovemind: For Partners",
      "description":
          "A platform that connects you to people going through mental and emotional health issues like stress, anxiety, trauma, relationship issues, work pressure, depression, self-image issues, insomnia, processing negative emotions like anger, boredom, loneliness and enables you to help them through assessment tests and online counselling sessions",
      "image": "assets/images/clovemind_provider/clovemind_provider.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": ["Flutter", "Firebase", "Node.js", "Socket.io"],
      "github": null,
      "playStore": "https://play.google.com/store/apps/details?id=com.clovemind.therapist&pcampaignid=web_share",
      "appStore": "https://apps.apple.com/in/app/clovemind-for-partners/id1659671351",
      "year": "2022",
      "role": "Mobile App Developer",
      "projectType": "Partner Portal",
      
    },
    {
      "title": "Pave",
      "description":
          """Pave is the first ever athlete marketplace built to help aspiring school athletes unlock their full potential — on and off the field.

Whether you dream of playing college sports, earning NIL deals, or getting guidance and mentorship from someone who's already walked your path, Pave connects you directly with college & professional athletes and sports development experts who can help you get there.

Through 1:1 video calls, live messaging, young athletes and parents gain access to personalized guidance - gaining the feedback, clarity, and exposure needed to navigate recruiting, athlete development, and NIL opportunities with confidence.""",
      "image": "assets/images/pave/pave.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": [
        "Flutter",
        "Firebase",
        "REST API",
        "Push Notifications",
        "Razor Pay"
      ],
      "github": null,
      "playStore": null,
      "appStore": "https://apps.apple.com/in/app/pave-futures/id6749158266",
      "year": "2024",
      "role": "Freelancer",
      "projectType": "Mobile App",
    },
    {
      "title": "Request Management",
      "description":
          "Request management system help the admin & the users to share the requests from area representatives.  It helps the secretary to manage there work, plan there day & keep with the admin.",
      "image": "assets/images/request_management/rm.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": ["Flutter", "Laravel", "MySQL", "Bloc"],
      "github": null,
      "playStore": "https://play.google.com/store/apps/details?id=com.isoft.rms&pcampaignid=web_share",
      "appStore": null,
      "year": "2021",
      "role": "Lead Developer",
      "projectType": "Management App",
      
    },
    {
      "title": "AI-Octopus",
      "description":
          "Social Media Management CRM Software, CRM Tool.  Aioctopus offers Social Media Software and management tool that enable organisations to increase sales, loyalty program, easy ticketing system and fast accurate response.",
      "image": "assets/images/ai_octopus/ai_octopus.png",
      "categories": ["Flutter"],
      "media": [],
      "mediaHasBezel": true,
      "technologies": ["Flutter", "Node.js", "MongoDB", "Websockets"],
      "github": null,
      "playStore": "https://play.google.com/store/apps/details?id=com.isoft.octopus&pcampaignid=web_share",
      "appStore": "https://apps.apple.com/in/app/ai-octopus/id1559212459",
      "year": "2021",
      "role": "Full-Stack Engineer",
      "projectType": "CRM Software",
      "backstory":
          "Small business owners struggle to maintain a consistent presence across multiple social media platforms, losing valuable client leads.",
      "myRole":
          "Full-Stack Engineer building the CRM pipeline, social media API integrations, and automated ticketing engine.",
      "challenge":
          "Integrating multiple divergent social media platform APIs (Facebook, Instagram, LinkedIn) into a unified inbox panel.",
      "approach":
          "Centralized Node.js bridge API that translates individual platform webhook updates into a standardized socket message payload.",
      "solution":
          "Designed a unified social media CRM app featuring platform scheduling, automated ticket routing, and AI-driven smart replies.",
      "keyOutcomes":
          "Onboarded 20+ corporate clients, increasing their average customer response time by 50%.",
      "whatMakesThisDifferent":
          "Combines social media publishing with CRM tickets, allowing users to transition a comment into a sales lead instantly.",
      "whatITookFromIt":
          "Learned about social media API constraints, payload mapping, and real-time webhook routing."
    },
    {
      "title": "News Fetcher",
      "description":
          "Social Media Monitoring Tool, News Fetch, Social Media Aggregator, Scraping Tool.  Newsfetcher tool offers advanced media monitoring your mentions carefully on any news paper, forums, blogs and any Social media platform.",
      "image": "assets/images/newsfetcher/newsfetcher.png",
      "categories": ["Flutter"],
      "media": [],
      "technologies": ["Flutter"],
      "github": null,
      "playStore": null,
      "appStore": null,
      "year": "2020",
      "role": "Lead Developer",
      "projectType": "Aggregator App",
      "backstory": "",
      "myRole": "",
      "challenge": "",
      "approach": "",
      "solution": "",
      "keyOutcomes": "",
      "whatMakesThisDifferent": "",
      "whatITookFromIt": ""
    },
    
    {
      "title": "Tix Alert",
      "description":
          "A parking intelligence app that helps drivers avoid tickets by identifying restricted zones, disabled parking, and available parking spots in real-time across urban areas.",
      "image": "assets/images/tix_alert/tix_alert.png",
      "categories": ["iOS"],
      "media": [],
      "keyFeatures": [
        "Real-time parking zone visualization (color-coded maps)",
        "Voice-guided parking alerts",
        "User-reported violation hotspots",
        "Meter reminder notifications",
      ],
      "technologies": [
        "Flutter (Cross-platform)",
        "Firebase Realtime Database",
        "Google Maps API",
        "Geofencing API",
        "Stripe Payment Integration",
      ],
      "github": null,
      "playStore": null,
      "appStore": null,
      "year": "2017",
      "role": "Software Developer",
      "projectType": "Parking App",
      "backstory": "",
      "myRole": "",
      "challenge": "",
      "approach": "",
      "solution": "",
      "keyOutcomes": "",
      "whatMakesThisDifferent": "",
      "whatITookFromIt": ""
    },{
      "title": "to Share",
      "description":
          "This app helps to share the play time or usage time equally between the kids or teenage who interested to share usage of one IPAD/IPHONE.",
      "image": "assets/images/to_share/to_share.png",
      "categories": ["iOS"],
      "media": [],
      "keyFeatures": [
        "Time sharing",
        "Usage tracking",
        "Parental controls",
      ],
      "technologies": ["iOS", "Swift", "Parental Controls", "Time Management"],
      "github": null,
      "playStore": null,
      "appStore": null,
      "year": "2016",
      "role": "Software Developer",
      "projectType": "Alarm App",
      "backstory": "",
      "myRole": "",
      "challenge": "",
      "approach": "",
      "solution": "",
      "keyOutcomes": "",
      "whatMakesThisDifferent": "",
      "whatITookFromIt": ""
    }
  ];
}
