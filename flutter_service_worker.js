'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "d0d6c2b536dc3059a018277c0aa98d0f",
"version.json": "1ac57eb0214a8f5216f1da7dd479b33f",
"index.html": "95c4301d4236fb3edfbe555c1e9ab14a",
"/": "95c4301d4236fb3edfbe555c1e9ab14a",
"styles.css": "713d8c49627c44e221afff6b71d135b8",
"main.dart.js": "b49f38cee762a88933147d701e1b643b",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5d2d0d552b4b7032bdc19908e214b22a",
"icons/Icon-192.png": "5d2d0d552b4b7032bdc19908e214b22a",
"icons/Icon-512.png": "5d2d0d552b4b7032bdc19908e214b22a",
"scripts/botd-1.1.0.js": "59799f492214d206697685b336ec3121",
"manifest.json": "14533758d5adebb52c270151b0335f00",
"assets/NOTICES": "330a9be7f7bf1f815cd7fed375beca27",
"assets/FontManifest.json": "67a28da3784fc091c2f816d615fbf08a",
"assets/AssetManifest.bin.json": "dd2796d54646a006ad0838740e6e5a65",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "d4a838d080c0ca73081250ccbdce3222",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/vscode.svg": "a9aec31bb3e80bfbde2e10514e95ecc9",
"assets/assets/images/listen2re/android/screen7.png": "05e1b6ebe1e6c3a79dc7254fc9390b33",
"assets/assets/images/listen2re/android/screen6.png": "7ea55c9f2f240330fe9270f65797bdb5",
"assets/assets/images/listen2re/android/screen4.png": "b2599eef2b2253ea1765509aed19463c",
"assets/assets/images/listen2re/android/screen5.png": "001774f123c47d5ccd6d7c82c089a739",
"assets/assets/images/listen2re/android/screen1.png": "abd57ca8ef121f78321e8ccea765f6bc",
"assets/assets/images/listen2re/android/screen2.png": "139b48c7d5b48469deff90313fff1a7d",
"assets/assets/images/listen2re/android/screen3.png": "26acddd53994e0d1c32052bc709b0846",
"assets/assets/images/listen2re/android/screen8.png": "1f2a09caaafd30d8bd2d6786ec8ab1d7",
"assets/assets/images/listen2re/android/screen9.png": "694129199a6067b44f162309a1cba00b",
"assets/assets/images/listen2re/listen2re.png": "abd57ca8ef121f78321e8ccea765f6bc",
"assets/assets/images/Figma.svg": "52b36f2cdefb3bbc2182df2cdfd56fd7",
"assets/assets/images/gitlab.svg": "bb26faf343af240ffb5198d24cdf6d1d",
"assets/assets/images/Firebase.svg": "bc401396d62d87977065224b78aa0892",
"assets/assets/images/clovemind_provider/clovemind_provider.png": "6e852d63d207ddbced73d7872aae1287",
"assets/assets/images/clovemind_provider/android/screen4.png": "ee2b75e87676ca2945ee599fc6eb667a",
"assets/assets/images/clovemind_provider/android/screen5.png": "16067b87161fdad3171523f3f145bbfd",
"assets/assets/images/clovemind_provider/android/screen1.png": "6e852d63d207ddbced73d7872aae1287",
"assets/assets/images/clovemind_provider/android/screen2.png": "ac3903817afce96281697662252f22cb",
"assets/assets/images/clovemind_provider/android/screen3.png": "44f31f51f0c9bd2f5212735279d15c31",
"assets/assets/images/github.svg": "549cc38d8ddb8c4026429620be118452",
"assets/assets/images/IMG_7344.jpg": "78999259ff9e01aad001c6049ee44c3f",
"assets/assets/images/buffercode.png": "c4ef5d286d5c29347821cd2dec9c26bf",
"assets/assets/images/clove1.png": "956b1959ae4d1cead92aae48fe45e944",
"assets/assets/images/pickzy.png": "0b5625b4e8930891331f4551f2c84d24",
"assets/assets/images/objc.svg": "cdc53fd6b1b7f35acf5ee4657e83461d",
"assets/assets/images/clove2.png": "d3b15fb3b19406f748769b4d0c474efd",
"assets/assets/images/pave/pave.png": "635d106b65c91e981389e178f559b236",
"assets/assets/images/pave/android/screen7.png": "ea14130fe659506aa3b3b08d09234ba1",
"assets/assets/images/pave/android/screen6.png": "a24c4fab5d7108d6b231b820e614df3a",
"assets/assets/images/pave/android/screen4.png": "73d8ba8d7de0ead8de37366d405f21fc",
"assets/assets/images/pave/android/screen5.png": "d611c043fe37d3e7fd7f0e8a3fcabc7e",
"assets/assets/images/pave/android/screen1.png": "635d106b65c91e981389e178f559b236",
"assets/assets/images/pave/android/screen2.png": "291edc1e6ead16538c6bc3245a2cc844",
"assets/assets/images/pave/android/screen3.png": "4bc80ceac49b0208ea83b17784ea34a7",
"assets/assets/images/pave/android/screen18.png": "f7dc08b36f4782419125678543409e91",
"assets/assets/images/pave/android/screen19.png": "f64168230c3e6f187e8daa2c54aaab50",
"assets/assets/images/pave/android/screen21.png": "74b4c27d8997439b70475c48ab69026b",
"assets/assets/images/pave/android/screen20.png": "15b827b037cb4412e3fab34d6db882cb",
"assets/assets/images/pave/android/screen22.png": "3a52b5721b6ad16aa8ef007e2e09e19a",
"assets/assets/images/pave/android/screen12.png": "0e4d7fc16b80b5e54623c8135be699e7",
"assets/assets/images/pave/android/screen13.png": "65c5648287f5a6b3132989ed7d6402cd",
"assets/assets/images/pave/android/screen11.png": "f29aa64d545f9ede5316d6f6c6bdeb28",
"assets/assets/images/pave/android/screen10.png": "0495af0ecd7030f45569fc2bce6d83ef",
"assets/assets/images/pave/android/screen14.png": "8906bfd5148579d2c45770b138aa2ae4",
"assets/assets/images/pave/android/screen15.png": "924db13a51145de6693b24c7c1eaf30d",
"assets/assets/images/pave/android/screen17.png": "1b68191f4a8e3ae2d8fffde1d8a67226",
"assets/assets/images/pave/android/screen16.png": "0e167fdfd7be9e17ab72c400baaef42e",
"assets/assets/images/pave/android/screen14a.png": "a8fe704fe157ac5be7fffb2383a75693",
"assets/assets/images/pave/android/screen8.png": "03eadfaa7412bda79a6d2f480658c0bf",
"assets/assets/images/pave/android/screen9.png": "62bcf665b0354b4cebd77a63f4c096d7",
"assets/assets/images/hakika_banking_app/banking_app.png": "d38adce5db0633414007b7cd15e78f60",
"assets/assets/images/hakika_banking_app/android/screen4.png": "030bcd1212e758527aecb8da00acf4ba",
"assets/assets/images/hakika_banking_app/android/screen1.png": "d38adce5db0633414007b7cd15e78f60",
"assets/assets/images/hakika_banking_app/android/screen2.png": "db2be35a5f59d069a5097f6ce518040c",
"assets/assets/images/hakika_banking_app/android/screen3.png": "639a63e618b06bef9869c99ada1ca05d",
"assets/assets/images/aioctopus.png": "d4a42c5d3a80b1a874b5930ddddafd02",
"assets/assets/images/Flutter.svg": "590fab54bb261d391526973ac7b18e77",
"assets/assets/images/forager1.jpg": "d7ca09123de62dd00b62faa7d8567955",
"assets/assets/images/git.svg": "c6a9bc63fc499e4111999176d09f8c18",
"assets/assets/images/ai_octopus/ai_octopus.png": "fd29c164906db30bf9f92973289bf005",
"assets/assets/images/ai_octopus/android/screen7.png": "3e88588cc72c31ab36b930e21627ac02",
"assets/assets/images/ai_octopus/android/screen6.png": "9977d4b861dfa5459580065be8de1f39",
"assets/assets/images/ai_octopus/android/screen4.png": "248b591fb86b0e5ef1d1d9840d3ae09e",
"assets/assets/images/ai_octopus/android/screen5.png": "6407cd185f9c0d1cd885332c8764316b",
"assets/assets/images/ai_octopus/android/screen1.png": "fd29c164906db30bf9f92973289bf005",
"assets/assets/images/ai_octopus/android/screen2.png": "7569031fe7087e79a6fb18e60706729a",
"assets/assets/images/ai_octopus/android/screen3.png": "ee24ca54399e0bfd638edaf9bfb31a9e",
"assets/assets/images/all_calculator/tablet/screen4.png": "95a2c4b35dd545904ff880ab6620147e",
"assets/assets/images/all_calculator/tablet/screen1.png": "50fadcc80176abd1bbcca6d820dd044e",
"assets/assets/images/all_calculator/tablet/screen2.png": "95a2c4b35dd545904ff880ab6620147e",
"assets/assets/images/all_calculator/tablet/screen3.png": "c1276afbe0af96bb4b605135921ade97",
"assets/assets/images/all_calculator/android/screen4.jpg": "f0c9bff32cb5d1d6eb72b2425341d184",
"assets/assets/images/all_calculator/android/screen1.jpg": "cf26f62ec04c9caf501a23bdf88977a1",
"assets/assets/images/all_calculator/android/screen2.jpg": "867a98b7c7c781c3dad4b7bce7b3c999",
"assets/assets/images/all_calculator/android/screen3.jpg": "3313339986bfa64f9d0e2748a2aacb98",
"assets/assets/images/all_calculator/all_calculator.png": "82c339ab77946beab9841abc6b1872b3",
"assets/assets/images/Xcode.svg": "01ad75eab7bc3dbddcaf073c673c2b77",
"assets/assets/images/cheerish/android/screen4.jpg": "5f85f2ae9ea1bfd7879d4b479ad5afa7",
"assets/assets/images/cheerish/android/screen1.jpg": "bba30c582785229abcff4792bd851d6c",
"assets/assets/images/cheerish/android/screen2.jpg": "a6ad55e7212307627706bb479eadbbac",
"assets/assets/images/cheerish/android/screen3.jpg": "1974a508f737b57dd7f2e9f374112e9e",
"assets/assets/images/cheerish/cheerish.jpg": "bba30c582785229abcff4792bd851d6c",
"assets/assets/images/forager_mobil_mokup.jpg": "73a1af9713d2bc67a6b69181d9f772ef",
"assets/assets/images/newsfetcher/newsfetcher.png": "f95441b3f7b3ce10147fcdcf78a155e7",
"assets/assets/images/newsfetcher/android/screen4.png": "aa49bc1d2aab3d4890066e05f7157200",
"assets/assets/images/newsfetcher/android/screen1.png": "fd4c295056b8fb28e384215564a05908",
"assets/assets/images/newsfetcher/android/screen2.png": "493288a05155e65630fc9e05b24b237a",
"assets/assets/images/newsfetcher/android/screen3.png": "cc5bf50b186eb118f60a34a25e47ab97",
"assets/assets/images/jira.svg": "1ce8961eb8b757a805c0858574341f19",
"assets/assets/images/rm.png": "1520db2823bd915b6343b788b086c5fe",
"assets/assets/images/riot.png": "01f886ca63cdb32bc7ece426967119e8",
"assets/assets/images/isoftcell.png": "ff26c18fd81975c8c874b1f74696d852",
"assets/assets/images/Dart.svg": "1e2ef8649acb27545b23dca10a25055f",
"assets/assets/images/to_share/android/screen1.png": "d6d963b5e6f9bb0c1b23683a69aca24a",
"assets/assets/images/to_share/android/screen2.png": "5f94270dd8af5534ac7008e0c1f37785",
"assets/assets/images/to_share/android/screen3.png": "64ced053e8ef39203647aeb2e4ee0f08",
"assets/assets/images/to_share/to_share.png": "41e9278d9836b9e94412058aa5874f8a",
"assets/assets/images/loader/logo.png": "5d2d0d552b4b7032bdc19908e214b22a",
"assets/assets/images/clovemind_care/clovemind_care.png": "4f58d6ac121da3cc7a5514b0592479df",
"assets/assets/images/clovemind_care/android/screen7.png": "fe96b4c8d50a51cbca03149767c7cb86",
"assets/assets/images/clovemind_care/android/screen6.png": "1b0aa00a822b47134906c86e7a83dff2",
"assets/assets/images/clovemind_care/android/screen4.png": "4f58d6ac121da3cc7a5514b0592479df",
"assets/assets/images/clovemind_care/android/screen5.png": "0784909eb7824cf1dcf448e4ccad74b3",
"assets/assets/images/clovemind_care/android/screen1.png": "ceb391598bd800f3b989a68d5bb6738e",
"assets/assets/images/clovemind_care/android/screen2.png": "1822198897a422342063631a1201c626",
"assets/assets/images/clovemind_care/android/screen3.png": "a1daaf38b2b168ecc838f9af9aa30432",
"assets/assets/images/clovemind_care/android/screen8.png": "ade4ccbfa2623e1fa5a63b2b1b262f9d",
"assets/assets/images/AndroidStudio.svg": "15fe69d632d823f40759a8149c5afbc3",
"assets/assets/images/swiftui.svg": "74c54b44d1137a48aeb5f77153c9bace",
"assets/assets/images/parking_sthal/android/screen7.png": "162e79390faa67b34709e70fac3eab22",
"assets/assets/images/parking_sthal/android/screen6.png": "d0e7b2cc2f3c5260e7fdda1fba3152fb",
"assets/assets/images/parking_sthal/android/screen4.png": "4a1057c8688980b594419640c99ac165",
"assets/assets/images/parking_sthal/android/screen5.png": "243c029b111ab953e7b017db4d36ee18",
"assets/assets/images/parking_sthal/android/screen1.png": "b7e575380092c75d9d0039e00e6e643c",
"assets/assets/images/parking_sthal/android/screen2.png": "42f9caf8180c71d0bd0a68b98c07440b",
"assets/assets/images/parking_sthal/android/screen3.png": "f5138bf9f6daeb23f639d928fd0b6686",
"assets/assets/images/parking_sthal/android/screen8.png": "75b9ac5c3f8d23b44a09ff9b8e969f2b",
"assets/assets/images/parking_sthal/parking_sthal.png": "ae542441a71c3d762786e59e59a202f5",
"assets/assets/images/request_management/tablet/screen4.png": "0c720a6d3c344ee4e362323a1734a02a",
"assets/assets/images/request_management/tablet/screen1.png": "8278cc76ba15ead688b4ec9e7436b4ce",
"assets/assets/images/request_management/tablet/screen2.png": "ffec7c76d1612705bda49e5b11ceba5c",
"assets/assets/images/request_management/tablet/screen3.png": "826a95961b07b0798baf7592310f38e8",
"assets/assets/images/request_management/rm.png": "1520db2823bd915b6343b788b086c5fe",
"assets/assets/images/request_management/android/screen4.jpg": "07e6d279f4a18debf8ac339c9e57b801",
"assets/assets/images/request_management/android/screen1.jpg": "17ed2d41fa77c84e57e40acf629fc643",
"assets/assets/images/request_management/android/screen2.jpg": "b518025739fab1e1c0c30e0b34a43198",
"assets/assets/images/request_management/android/screen3.jpg": "1746edfd2fb01006d6a98ed9fa7cbe08",
"assets/assets/images/call_pik/android/screen1.jpg": "145aa84006f28f989a207cd4d71e404b",
"assets/assets/images/call_pik/android/screen2.jpg": "128b139ff377788cdfcc8b6647fff63d",
"assets/assets/images/call_pik/call_pik.jpg": "145aa84006f28f989a207cd4d71e404b",
"assets/assets/images/tix_alert/tix_alert.png": "131280e9158a8ace08b6533466682b6c",
"assets/assets/images/tix_alert/android/screen1.png": "f03d275c1bc557e1dba8fcb65157172b",
"assets/assets/images/tix_alert/android/screen2.png": "27609d70450a490835fbd5fd7b99edfd",
"assets/assets/images/tix_alert/android/screen3.png": "b27d9eaa05ac40f4b88a13a890673dfd",
"assets/assets/images/Postman.svg": "2b33a1f6fa1f0f89f6f2b757bf9d9c6b",
"assets/assets/images/mhb.png": "642eaacb3201ad191b965f95b066af59",
"assets/assets/images/madeByfire.png": "c1d858a64ec4c9c86c23c51ba03bd331",
"assets/assets/images/swift.svg": "a52c32035bb9f8cc14d28b891bfdb9c9",
"assets/assets/images/forager_pro/android/screen1.png": "e75f85e2639bde5e98adb921dbfb7ff8",
"assets/assets/images/forager_pro/android/screen2.png": "218b4d65d7e4871c5927b3f34e552155",
"assets/assets/images/forager_pro/android/screen3.png": "9fd2d4d7effb143ae6ca9f52a34fc0e3",
"assets/assets/images/forager_pro/forager_pro.jpg": "e961b0136e32903df03937e34c08a496",
"assets/assets/images/bg.jpeg": "c6449162dc3940daa640a43101cfd66c",
"assets/assets/images/listen2RE.png": "0a1325268d10ac22087b641ffa1a1c2b",
"assets/assets/images/richie_rich/android/screen7.png": "44ed774b288fb7cd7aa89411e805776d",
"assets/assets/images/richie_rich/android/screen6.png": "468d9717fbf6cc30439b30ef2cbf9f37",
"assets/assets/images/richie_rich/android/screen4.png": "d2bd5ba318d13b353e55444ada00ce63",
"assets/assets/images/richie_rich/android/screen5.png": "d2bd5ba318d13b353e55444ada00ce63",
"assets/assets/images/richie_rich/android/screen1.png": "f2b5365961ea0060fca13389711cbf28",
"assets/assets/images/richie_rich/android/screen2.png": "44ed774b288fb7cd7aa89411e805776d",
"assets/assets/images/richie_rich/android/screen3.png": "468d9717fbf6cc30439b30ef2cbf9f37",
"assets/assets/images/richie_rich/richie_rich.png": "3b07762571ef042a7c248ec7472f87d3",
"assets/assets/images/coasian.png": "670744c53e4c1d0eba983acc1f0085a4",
"assets/assets/icons/github.svg": "9226aa209923e38c0a6ddcb236e2bc68",
"assets/assets/icons/download.svg": "628700a3031424d215a441fab2da1731",
"assets/assets/icons/check.svg": "4220c82511cc1dfb40b8bba7d25c5f55",
"assets/assets/icons/dribble.svg": "d392567c5678d42472d2c7b766268101",
"assets/assets/icons/linkedin.svg": "5b2195ddf9e879047dd8a163c4194920",
"assets/assets/icons/twitter.svg": "a4a0163fef48a4247a305528c07bc4fa",
"assets/assets/icons/behance.svg": "35ad2d47e647d0b168e7707b2984c6b5",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
