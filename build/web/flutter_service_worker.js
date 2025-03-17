'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "de7737ab72fea5d638781a798c0663ae",
"version.json": "1ac57eb0214a8f5216f1da7dd479b33f",
"index.html": "3aee1a230c74b3f98d8633fd89a1bd17",
"/": "3aee1a230c74b3f98d8633fd89a1bd17",
"main.dart.js": "d0a06032fb643f7198c28632d86318a1",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "14533758d5adebb52c270151b0335f00",
"assets/AssetManifest.json": "432b18d2a1c61205622d6f5b0691b391",
"assets/NOTICES": "9e8d11d505382cd53f8f73726d39acca",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/AssetManifest.bin.json": "9a2a216b4213bf5b4dbdec370188a82b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6123099d660c28453ae67f278df0af82",
"assets/fonts/MaterialIcons-Regular.otf": "1d82e14f9fa711be560627294de45719",
"assets/assets/images/vscode.svg": "83595be449fe6fb3e88031680969fde1",
"assets/assets/images/figma.svg": "e0a8e70c5a4566067ebcad70b45b5b59",
"assets/assets/images/gitlab.svg": "7ff55b0b85cb31e2affde11a79b77c5b",
"assets/assets/images/firebase.svg": "53465af2a6aabad6441810cacf029816",
"assets/assets/images/github.svg": "2c8f00e4486e527e17fac09b9f9b4db7",
"assets/assets/images/IMG_7344.jpg": "78999259ff9e01aad001c6049ee44c3f",
"assets/assets/images/buffercode.png": "c4ef5d286d5c29347821cd2dec9c26bf",
"assets/assets/images/clove1.png": "956b1959ae4d1cead92aae48fe45e944",
"assets/assets/images/pickzy.png": "0b5625b4e8930891331f4551f2c84d24",
"assets/assets/images/newsfetcher.png": "f95441b3f7b3ce10147fcdcf78a155e7",
"assets/assets/images/clove2.png": "d3b15fb3b19406f748769b4d0c474efd",
"assets/assets/images/aioctopus.png": "d4a42c5d3a80b1a874b5930ddddafd02",
"assets/assets/images/flutter.svg": "74f7e78eab117efa845608c8cb5ee5a2",
"assets/assets/images/forager1.jpg": "d7ca09123de62dd00b62faa7d8567955",
"assets/assets/images/git.svg": "0964a20e1f4a0ad61980543c8a605935",
"assets/assets/images/forager_mobil_mokup.jpg": "73a1af9713d2bc67a6b69181d9f772ef",
"assets/assets/images/jira.svg": "27d91564278412d24e7b7259e55ac28b",
"assets/assets/images/rm.png": "1520db2823bd915b6343b788b086c5fe",
"assets/assets/images/riot.png": "01f886ca63cdb32bc7ece426967119e8",
"assets/assets/images/isoftcell.png": "ff26c18fd81975c8c874b1f74696d852",
"assets/assets/images/dart.svg": "ef4adc9890e2cbaa90a8e793901cc8e0",
"assets/assets/images/androidstudio.svg": "52108373b5e3d7ffab2932aa31090f12",
"assets/assets/images/mhb.png": "642eaacb3201ad191b965f95b066af59",
"assets/assets/images/madeByfire.png": "c1d858a64ec4c9c86c23c51ba03bd331",
"assets/assets/images/swift.svg": "a52c32035bb9f8cc14d28b891bfdb9c9",
"assets/assets/images/bg.jpeg": "c6449162dc3940daa640a43101cfd66c",
"assets/assets/images/listen2RE.png": "0a1325268d10ac22087b641ffa1a1c2b",
"assets/assets/images/coasian.png": "670744c53e4c1d0eba983acc1f0085a4",
"assets/assets/icons/github.svg": "9226aa209923e38c0a6ddcb236e2bc68",
"assets/assets/icons/download.svg": "628700a3031424d215a441fab2da1731",
"assets/assets/icons/check.svg": "4220c82511cc1dfb40b8bba7d25c5f55",
"assets/assets/icons/dribble.svg": "d392567c5678d42472d2c7b766268101",
"assets/assets/icons/linkedin.svg": "5b2195ddf9e879047dd8a163c4194920",
"assets/assets/icons/twitter.svg": "a4a0163fef48a4247a305528c07bc4fa",
"assets/assets/icons/behance.svg": "35ad2d47e647d0b168e7707b2984c6b5",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
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
