import 'package:flutter/material.dart';
import 'package:flutter_profile/screens/experience/exp_model.dart';
import 'package:flutter_profile/screens/projects/project_model.dart';

const primaryColor = Color(0xFFFFC107);
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
const bgColor = Color(0xFF1E1E28);

const defaultPadding = 20.0;
const defaultDuration = Duration(seconds: 1); // we use it on our animation
const maxWidth = 1440.0; // max width of our web

const linkedIn = "https://www.linkedin.com/in/shankaranarayanasharma/";
const github = "https://github.com/shankaranarayanasharma";
const resume =
    "https://docs.google.com/document/d/1bbiD__qyN593g120H-atGKBv0mgIdb52/edit?usp=sharing&ouid=110991434288520766971&rtpof=true&sd=true";

class Constants {
  static const String appName = 'Shankaranarayana Sharma';

  static Uri devURL = Uri.parse('https://dileepabandara.dev');
  static Uri repoURL = Uri.parse('https://github.com/shankaranarayanasharma');

  static const String copyright =
      "Copyright ©2025 Shankaranarayana Sharma. All Rights Reserved.";
}

List<Experience> experiences = [
  Experience(
    title: "Freelancer",
    company: "",
    duration: "Dec 2021 - Present",
    location: "Chennai · Remote",
    type: "",
    skills: ["Flutter", "Swift", "Swift UI", "Firebase"],
    icon: Container(),
  ),
  Experience(
    title: "Lead Mobile Developer",
    company: "Isoftcell",
    duration: "Dec 2019 - Dec 2021",
    location: "Bengaluru",
    type: "Full Time",
    skills: ["Flutter", "Swift", "Firebase"],
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
    skills: ["Swift", "Firebase"],
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

final List<ProjectModel> blogPosts = [
  ProjectModel(
    title: 'Mwanga Hakika Mobile App',
    categories: ['iPhone', 'iPad'],
    author: 'Jenny Smith',
    date: '22 July 2023',
    image: 'assets/images/mhb.png',
    description: "MHB mobile app is a comprehensive tool designed to provide MHB users with convenient and secure access to their bank accounts via their smartphones.",
  ),
  ProjectModel(
    title: 'Listen2RE',
    categories: ['Flutter'],
    author: '',
    date: '22 July 2023',
    image: 'assets/images/listen2RE.png',
    description: 'The Audio Learning App that helps you achieve your study goals, your way. No more boring books, no more endless reading - With Listen2RE, you can listen to your favorite books, publications, and current affairs while working out, cooking, or just relaxing. Our platform offers syllabus-specific content, famous publication audiobooks, daily and weekly current affairs updates, and motivational podcasts to help you retain what you learn. Join our community and discover a better way to study'
  ),
  ProjectModel(
    title: 'Clovemind : Mental Health Care',
    categories: ['Flutter'],
    author: '',
    date: '22 July 2023',
    image: 'assets/images/clove1.png',
    description: 'Counselling App to improve mental fitness and well-being.  Feeling anxious, stressed, unhappy or lonely? Unable to effectively process your emotions, thoughts, and feelings? Download Clove Mind online counselling app now for FREE to seek support from trained listeners and therapists anytime, anywhere!'
  ),
  ProjectModel(
    title: 'Clovemind: For Partners',
    categories: ['Flutter'],
    author: '',
    date: '22 July 2023',
    image: 'assets/images/clove2.png',
    description: 'A platform that connects you to people going through mental and emotional health issues like stress, anxiety, trauma, relationship issues, work pressure, depression, self-image issues, insomnia, processing negative emotions like anger, boredom, loneliness and enables you to help them through assessment tests and online counselling sessions'
  ),
  ProjectModel(
    title: 'Request Management',
    categories: ['Flutter'],
    author: '',
    date: '22 July 2023',
    image: 'assets/images/rm.png',
    description: 'Request management system help the admin & the users to share the requests from area representatives.  It helps the secretary to manage there work, plan there day & keep with the admin.'
  ),
  ProjectModel(
    title: 'AI-Octopus',
    categories: ['Flutter'],
    author: '',
    date: '22 July 2023',
    image: 'assets/images/aioctopus.png',
    description: 'Social Media Management CRM Software, CRM Tool.  Aioctopus offers Social Media Software and management tool that enable organisations to increase sales, loyalty program, easy ticketing system and fast accurate response.'
  ),
  ProjectModel(
    title: 'News Fetcher',
    categories: ['Flutter'],
    author: '',
    date: '22 July 2023',
    image: 'assets/images/newsfetcher.png',
    description: 'Social Media Monitoring Tool, News Fetch, Social Media Aggregator, Scraping Tool.  Newsfetcher tool offers advanced media monitoring your mentions carefully on any news paper, forums, blogs and any Social media platform.'
  ),
];
