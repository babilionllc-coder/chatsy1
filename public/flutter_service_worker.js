'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "6ae0957978d57adaaf737db7588e4c71",
"version.json": "1509cccfe6fda1499d8c3f09123cf1b8",
"index.html": "e877df4cfdbb05a375fe3bbced8628f8",
"/": "e877df4cfdbb05a375fe3bbced8628f8",
"main.dart.js": "ef7c142216b79879311d809238701083",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "fa5e4dd66308ed584b82c9cc58debad4",
"assets/AssetManifest.json": "a4304761263f3f930b96e9043b3bc459",
"assets/NOTICES": "b22e52e7eb62b6b2e6928e9790689f41",
"assets/FontManifest.json": "39b42bf51469eb120eba14a7b5949167",
"assets/AssetManifest.bin.json": "94abfbd2bd32fc7e6e8d95c5ab6a96f9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "2694fa52cbbeee5883e5dfa9a6990f01",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "529929547ba173c3f602c3d57dafcb4a",
"assets/fonts/MaterialIcons-Regular.otf": "a2297cd3bc865a3be525e28fcc363fbd",
"assets/assets/svg/ic_eye_slash.svg": "30125a80521689ce793f9cf0ca946ed4",
"assets/assets/svg/ic_profile.svg": "f95fa5cbe6a8e9516d98d10c66bcea11",
"assets/assets/svg/ic_text_select.svg": "935bb5712c6faf6d80bc2eaf90d3a519",
"assets/assets/svg/ic_eye.svg": "23e90299d42b8d2aeb8cc29097521fc3",
"assets/assets/svg/ic_read_loud.svg": "b04712cf5324bd591ea8aa5fe2d02fba",
"assets/assets/svg/ic_done.svg": "4fb23563299bf633ac9d3a6c80bba207",
"assets/assets/svg/ic_edit-2.svg": "ef82b0aea2449f2e67419cdccafe1aac",
"assets/assets/svg/ic_copy.svg": "ec98fac3f38acf94898ee31d34c8b2cb",
"assets/assets/svg/ic_edit.svg": "13aad8281481217c03f2bb909ab318a2",
"assets/assets/svg/ic_magic_stick.svg": "2c37b1e5da15b72bf3d68254ea4da2e9",
"assets/assets/jsons/happy_users.json": "894d2f80ec2ffedf7dee93019d81d84b",
"assets/assets/jsons/Home%2520Dark.json": "90f4c18cd633e5055d04342b7069e2d8",
"assets/assets/jsons/congrats.json": "fd2eb2a7629fcdc1078371059f5320bf",
"assets/assets/jsons/ai_assistant_dark.json": "ea892ad5d15e744438871cbb60e756ca",
"assets/assets/jsons/language.json": "cede7431af524396801624ad4bd37347",
"assets/assets/jsons/intro_3.json": "2e72f116c500925bdd4eb1dcc061a0ec",
"assets/assets/jsons/ai_assistant.json": "61f1fa64eefc5b729e8d4c90f3b3ed9b",
"assets/assets/jsons/intro_2.json": "683bdfbb76116736a30149e10205c26c",
"assets/assets/jsons/Templates.json": "4b8e2d5e82dd3cd1382471a7688c862c",
"assets/assets/jsons/intro_1.json": "1980e10c9002f26585b0a4c9e0fff864",
"assets/assets/jsons/notifications.json": "eca7537d4982efcc1c9d145b48491f95",
"assets/assets/jsons/congratulations.json": "54ae97b7282632f25a02e1cc94659435",
"assets/assets/jsons/off_bonus_gift.json": "ab4911ceef6587fb932543309c94c467",
"assets/assets/jsons/Templates%2520Dark.json": "bc7396b901a5477e4992e8b44fdea8af",
"assets/assets/jsons/congrats_offer_page.json": "de3928561121ea5b25e61e65d4ebfb28",
"assets/assets/jsons/problem_solving_tasks.json": "ee3fbaabadacd54367642a034d7a6b1f",
"assets/assets/jsons/Home.json": "87f424242b74c4a81b96ec47bf4e3039",
"assets/assets/images/weather.svg": "803d4f4ab96367b8b28f960a76b984e1",
"assets/assets/images/info.png": "4fabdfd04586c15cbb578eda9480695f",
"assets/assets/images/darkContactUs.png": "d9cc2d39fc1dc1ded3ea4b900ba0a882",
"assets/assets/images/ic_education.svg": "5da4b2c205d57ade3ae817a6f3abc7bf",
"assets/assets/images/sports.svg": "bf86612f5f4f7e3276cde1201fd5efe4",
"assets/assets/images/ic_new_chat.svg": "bdd959d4c2141fb6156e1c6956c8f183",
"assets/assets/images/true.png": "f6dde4637746fb2b9bb9cbb511c5a897",
"assets/assets/images/ic_fun.svg": "3dba75a3fe6139a32e80b969eb4161f7",
"assets/assets/images/voice_image_5.png": "b3b1e2148df4520a85c8d3e4dbe8360b",
"assets/assets/images/check.png": "60824d479080e8a55e2fecd10a9d16bf",
"assets/assets/images/entertainment.svg": "1b19119b4962d4f93bbb4537e3dc798f",
"assets/assets/images/voice_image_4.png": "b9ead925d6453385d51a693c73071482",
"assets/assets/images/rateImage_light.png": "8a0675a8f395d4ced806c8c640a58f8f",
"assets/assets/images/ic_historical.svg": "36b831da10fb05436745a6a1b3389a33",
"assets/assets/images/ic_game.svg": "aafb1980123f089a32ac237b2f5a08d1",
"assets/assets/images/darkAboutUs.png": "65aa205942dc114b7b84dcd769b3132a",
"assets/assets/images/summarize_pdf_image.png": "4b99135e43f7ab6527b40fde77451032",
"assets/assets/images/ic_personal.svg": "22a7d5a3487adbe65bb9b4f34827d7bf",
"assets/assets/images/mata_icon.png": "b3881597a56317b948a4b414a48954a6",
"assets/assets/images/ic_nature.svg": "d6534e54c4d20e48f1711576989a0b65",
"assets/assets/images/web_site_image.png": "d0b585c4462511cfb171dc3328d02c31",
"assets/assets/images/enhanced.png": "8cee196230948f5f1586fda3ebd4706e",
"assets/assets/images/ic_india.png": "926b4336f3b6e6a83ac02dbb7b22bd8f",
"assets/assets/images/notification_on.png": "783bb43238c900e76d806bf6c0d3a387",
"assets/assets/images/ic_money.svg": "303f007f0a70735fedf495d3bfe87885",
"assets/assets/images/ic_delete_photo.svg": "0bdf2ea143a7b238ce102946aa213150",
"assets/assets/images/image_scan_icon.png": "ff943a2a1325620eda98e64c2c7a7e28",
"assets/assets/images/ic_create_another.svg": "e337a3ad29ba32e371d1a56cc5fa0da4",
"assets/assets/images/user.svg": "2b833a8ce8ad9067de8598fff97dd8fc",
"assets/assets/images/ic_voice.png": "c5066a99a9b96aa62fa4a0e6beac1f2f",
"assets/assets/images/lightIcSend.png": "a0760a719b37490db00863b2adebedf6",
"assets/assets/images/home.svg": "e0bcc585eb5c2a10c45f923c9133cde7",
"assets/assets/images/regenerate.svg": "0a2f747a36112c60a1b2e0eb85d158d4",
"assets/assets/images/ic_english.png": "30b86f941dce854e684beb4d40a3cbdd",
"assets/assets/images/delete_account.png": "38bd518724b501600ae7d1f08f820b95",
"assets/assets/images/arrow_chat.svg": "d3ac1d7c772da5fe13708e4f8b68bdb6",
"assets/assets/images/Frame-2.png": "f003e3f94bf609b40613967762d20101",
"assets/assets/images/logout.svg": "2503491b78625ac9a4edcee45f232b33",
"assets/assets/images/shopping.svg": "204464210fb43ef43f7a155c24a9d8cd",
"assets/assets/images/gallery.png": "ddaa09bd706e914a02063758c1e2e453",
"assets/assets/images/voice_image_3.png": "52ec118c32ed7a79ae6dead13e60bbca",
"assets/assets/images/knowledge.png": "d8dace8bded3f8835113c5c6a25192c0",
"assets/assets/images/dark.png": "b8f874b6aca81f133346e2337dcd126a",
"assets/assets/images/voice_image_2.png": "cec562a624e538d58b164bd2fc2967f6",
"assets/assets/images/ic_back1.svg": "9fa6f90a5f6bb85ddd7caa98b2ade05a",
"assets/assets/images/instagram2.png": "93032f03ca431604cddc8ac2ed0a7f98",
"assets/assets/images/ic_history.svg": "75743b2c8aaebab9175d649f794bc00a",
"assets/assets/images/Frame-1.png": "7b6ee1cca9005ea5e997551737a879fa",
"assets/assets/images/link.png": "be4e6f1462d49d43c44e7501d1d17814",
"assets/assets/images/instagram.png": "5c0f6c18f780535425eec432421a6625",
"assets/assets/images/health.png": "1032bacf2d26c49b93a7b59ee5e5d6f5",
"assets/assets/images/notification_permission.svg": "413de25ecfc6715b770f3cc83de6693a",
"assets/assets/images/darkUserId.png": "45548f97ee5da167cdfcb0c48c39fd96",
"assets/assets/images/voice_image_1.png": "06093030d2c0f1c71e007cae48209007",
"assets/assets/images/image_generation_image.png": "a8febc8c655b1f5f2dd34d94ffe10e46",
"assets/assets/images/ic_architecture.svg": "5bd206b77239834f1a6aad27d3a05b1c",
"assets/assets/images/ic_language_change.svg": "22cf8271cb956a5f38b7144b15a2f64e",
"assets/assets/images/ic_home.svg": "80fa157aafc1c0c1042bc9ea288354ab",
"assets/assets/images/user14.png": "0e8a9cd518e7653abbc44ee5250a6040",
"assets/assets/images/ic_camera.svg": "4d14c2c4f6844eed4f101d8a67f2e208",
"assets/assets/images/lock.svg": "9cce3d9b6457f7f6d81d7def099c0cc9",
"assets/assets/images/ic_spanish.png": "082487074e1c86bc6cb39f8730d8dc69",
"assets/assets/images/health.svg": "03e054097ac8f8da87753d093eba1ffe",
"assets/assets/images/ic_right.svg": "71bb43255ebb0fab6273ef3d0148f29e",
"assets/assets/images/ic_language.svg": "f077f99dffa8643e0d7bd84e91f7ba6f",
"assets/assets/images/ic_setting.svg": "cfe960fe7455a282c89cbf1ca2703e1d",
"assets/assets/images/real-time.png": "e2a37523e4c94a29c547ee1dc331407f",
"assets/assets/images/file.png": "c2706393a17f8dad3b21508a59099205",
"assets/assets/images/smooth_interactions.png": "6de7ce694b6ddfa32de25961a0e0e896",
"assets/assets/images/user15.png": "9b428fbbde70b35b9ba4e97f502aeaf2",
"assets/assets/images/chat_icon.png": "8f778b8a489c1108efaa8283fcd53723",
"assets/assets/images/microphone.png": "cbd90ed81d6707713f1d3cfdd1b0b668",
"assets/assets/images/ic_style.svg": "c611bfa78d116f686e6bab012952ea9e",
"assets/assets/images/vector.png": "2b8151da15ed001250f1cb07c068f436",
"assets/assets/images/templates.svg": "472bdaa6ca4d843e33627aa786f4fca8",
"assets/assets/images/user9.png": "7fc20d2a9ab44a3045ed1a01fee3ebb3",
"assets/assets/images/ic_math_image.svg": "66c7a25d5d82593d5305e345400b7230",
"assets/assets/images/user8.png": "158e4077aa78fbec63fc9887753bc216",
"assets/assets/images/select_style.png": "b98d6f9f20941b67345c86ca65b67cde",
"assets/assets/images/ic_notification.svg": "91580cd13b69805904ca8858b90f2a7c",
"assets/assets/images/ic_assistants.svg": "e65c38061cb48ecb9299bba1a2c48051",
"assets/assets/images/recycle.png": "8586bd25ff13323469ae4d989a56f0c5",
"assets/assets/images/rateImage.png": "ee521e6ba9d08797eae84f8b3c12ec00",
"assets/assets/images/darkForwardArrow.png": "9f606aaae403792cc99d6db5b91afe0e",
"assets/assets/images/ic_fitness.svg": "2d4c7607ce0faaab2206bde07710ddb4",
"assets/assets/images/user12.png": "c8eee2d42a962692f74028efb436c93f",
"assets/assets/images/arrow_up.svg": "35428f04b47c2fa4b32f571b3127a7b8",
"assets/assets/images/get_insights.png": "78c74afe765aee054c6bf8a4703b6d7d",
"assets/assets/images/text_from_image.png": "875157a72a112ae3acf29fdc8bb0ea12",
"assets/assets/images/darkTerms.png": "ad31125ef1c5c679b7f5c4ca335d218d",
"assets/assets/images/done2.png": "65ef3bccbce2d415575c1d973ca04db7",
"assets/assets/images/user13.png": "a2fcad4e83d024511031d83ba3a4b7c5",
"assets/assets/images/newspaper.svg": "83779744f74bbb4aa58caa891042ccc0",
"assets/assets/images/loading.gif": "60a7c53a137b81f9d443b93128cfac3f",
"assets/assets/images/lightSummarizeArticle.png": "75955b6e07406fff21416b0c232ae694",
"assets/assets/images/rating_image.png": "d8bad54b5a067553c4946c963cca77fb",
"assets/assets/images/user11.png": "a04e1a32c535c38e0ad21f75cd1b2ec3",
"assets/assets/images/tools.png": "bd8954dfc307bab7bc828431aad76779",
"assets/assets/images/ic_rotate_photo.svg": "7ef630cb1c586fe43f28596ba0028ff7",
"assets/assets/images/summarizePDF.png": "1ffe39223f1e8076032e4042c72d46f4",
"assets/assets/images/get_answer.png": "acd02175dfa2f3f702c57a399103456d",
"assets/assets/images/generate_images_icon.png": "62301b2ca71e76e7b374454a5db57684",
"assets/assets/images/ic_image_loading.svg": "f39de1d83808373e5c6a0ab4704b4225",
"assets/assets/images/assistants.svg": "4929dad75dbafed5fccee459a422643a",
"assets/assets/images/email.svg": "a86181492e3fbae996f4118780f4095d",
"assets/assets/images/watch.svg": "ccaffb6143e23917636ed82731d8de0c",
"assets/assets/images/scan_document.png": "a7e1cfcf274cfe3dfc447bb96d91b788",
"assets/assets/images/darkRateUs.png": "b1a4e4d24e1eacaed6dd2c7679a2e027",
"assets/assets/images/ic_share_photo.svg": "5b047d88978e2127dbc5153cd60329a8",
"assets/assets/images/user10.png": "888c0b103c98cefe8cd4433c3f100a2b",
"assets/assets/images/ic_gallery.svg": "d1dc9d9049a418df102cedb05ecedf15",
"assets/assets/images/close.svg": "fec686b73c1cccdbbe1b0e10b48cd258",
"assets/assets/images/copy.svg": "cbb32b1669d4bcdbd71623cd5fb503e5",
"assets/assets/images/social_image_light.png": "640a5ba56a995e839378e4b62e3c694d",
"assets/assets/images/special_offer_image.png": "3f3b3f95e2344c9c6a27a59ad97ee9ae",
"assets/assets/images/ic_portuguese.png": "ad1ed8ceb4efe61cbfedbf222272e2c2",
"assets/assets/images/user3.png": "c5668943bb6f76c8e7a386c44c7c07f5",
"assets/assets/images/user2.png": "58fa3f322438274623422af5f1269af3",
"assets/assets/images/summarize_document_image.png": "f958ba6e9096ae6b989043a2cf4d551c",
"assets/assets/images/ic_travel.svg": "63564fb986d457aabf467f646026ec58",
"assets/assets/images/ic_gallery1.svg": "9827e23615efa737b60d5b6fc5a8b2b6",
"assets/assets/images/tiktok.png": "6018a18379215b0e5651b7a9d21f2086",
"assets/assets/images/advanced_integration.png": "5a438481c1a8e6266ce9ae29c8d06039",
"assets/assets/images/apple.png": "8faa2ba672b809b5ed6f414386bcf02d",
"assets/assets/images/logo.json": "83721f6ec1ab07d5147a36b032b48352",
"assets/assets/images/brightness.png": "1a628da28c381a955caa7ff64d63a164",
"assets/assets/images/ic_fashion.svg": "49ba1d2f2b07e69ba71781b5e3c56836",
"assets/assets/images/generates.png": "5297ee6d1e43f73f69839b94f724d342",
"assets/assets/images/backgroundImage.png": "0983154d04d32fd75da0ce738675a45e",
"assets/assets/images/darkPrivacy.png": "484213969bfbbe77c67fb64897e0b118",
"assets/assets/images/ic_animals.svg": "4456462cefbf7d65616b2119e4ac3593",
"assets/assets/images/report.svg": "edba0f474eee7c249378cd60e0c30b07",
"assets/assets/images/play.svg": "57f07b8b467cb5a835bc5360f2512cb9",
"assets/assets/images/user1.png": "1d2c4499f4223cb6189cafefa9b23b25",
"assets/assets/images/ic_health.svg": "b48df8a9f5f1e56230fe7b8fa507f9fa",
"assets/assets/images/splashIcon.png": "88c1f21e2b493e659843ab28f4833f87",
"assets/assets/images/ic_theme.png": "db47df7647b8e1c4c47264959ce3694b",
"assets/assets/images/Logo.png": "1ae83cb75936894dd2f26e6378ac2c55",
"assets/assets/images/upload.png": "3e8645707802a4655bd4d1bf80661cf4",
"assets/assets/images/backgroundImageDark.png": "7f686261303d7ec64e6785241af5dbad",
"assets/assets/images/ai_chat_bot.json": "79000b26e6b421cccad35c59cdae32a4",
"assets/assets/images/user5.png": "bad0b0ed0682ddd5d3f4bc7eedc9e4d7",
"assets/assets/images/add-circle.png": "372382158e409156090410edf14d3b70",
"assets/assets/images/twitter.png": "86e49362df64ecd4c312b303bc39173d",
"assets/assets/images/ic_fantasy.svg": "ad814b3cc712adf079f0627815c1eff1",
"assets/assets/images/user4.png": "e892deea9f2e1e9177a61c01d3a776c0",
"assets/assets/images/contextual.png": "9d384118d37a0fff932e7a9f44d9e1d9",
"assets/assets/images/spirituality.svg": "1cc074788f5c4714116a40707d33dd27",
"assets/assets/images/dark_logo.png": "4c7b754b95a326696a0ea33717515518",
"assets/assets/images/edit.svg": "2ba74c6173b3df655f0005a0b0196216",
"assets/assets/images/ic_food.svg": "cd6c6db59ce77be4a80f43f5b159f426",
"assets/assets/images/restore.png": "4ab0fb991c658bee5da870f1c1859a44",
"assets/assets/images/intro_logo.png": "ba66919d87768c55baf6b5bbc145e0e0",
"assets/assets/images/creative.png": "28738d2a33f6f46815e17265944ba123",
"assets/assets/images/eye_slash.svg": "30125a80521689ce793f9cf0ca946ed4",
"assets/assets/images/efficient_tasks.png": "7810c2bfeff94dbef82889c831071edd",
"assets/assets/images/user6.png": "4170ffdafa491ff0e2193b1f78885112",
"assets/assets/images/pdf_upload.png": "5ac4b4981d5832b733740844e849b36c",
"assets/assets/images/ic_done.svg": "71a5db65a88389fdf9771570c08e1bcf",
"assets/assets/images/user7.png": "2d52fe5b77a859e725c4ffc41bf3e197",
"assets/assets/images/lightLink.png": "d544b03983b56c5b6e5d50362cdf0933",
"assets/assets/images/diamond.png": "2cc3d9dcc18539b2c33c1391f2943b40",
"assets/assets/images/delete.png": "ee7ea96aaa0613b4acd9177bb99f8fe6",
"assets/assets/images/select.svg": "253fc2781cc7055fa54613fa0b976588",
"assets/assets/images/Frame.png": "6dc3d808c935020dbdef59f21772598d",
"assets/assets/images/advanced.png": "c9d63c9753659fd8877f51cde96c5bf9",
"assets/assets/images/pdf.png": "b95d0e16703c1aa32b7b87e7a92f72e3",
"assets/assets/images/creativity.png": "05f7cdfdd2bf6a481ad4e485a6941676",
"assets/assets/images/describe_image.png": "c75183bb941326d65a2b6edf3eb933d8",
"assets/assets/images/eye.svg": "23e90299d42b8d2aeb8cc29097521fc3",
"assets/assets/images/lightClose.png": "9e3fe432fa071f502313774d6260d494",
"assets/assets/images/social_image_dark.png": "c6e83014ca2fa33d45cafcd8fe1e0eaf",
"assets/assets/images/ask_question.png": "3489420978ff00684178eb759cd219f8",
"assets/assets/images/edit.png": "af727f8b1097ab3bf090b0eb823bebec",
"assets/assets/images/efficiency.png": "9a3254c1e222d79b030c54cd449d80a9",
"assets/assets/images/lightMic.png": "a3cbaba8a4797d8d8a2258b14836686c",
"assets/assets/images/profile.svg": "c33faaf2e4583f15279ea0167689d717",
"assets/assets/images/share.svg": "1fe8b4067bbbf1ca7981e587dfb5f9b0",
"assets/assets/images/star.png": "429605ef98e67c09b469a07bc277641a",
"assets/assets/images/darkTranslate.png": "a6141279d58881372128c5f1ec031709",
"assets/assets/images/trues2.png": "0b1bc2a90a46cb925526edfe04054cb6",
"assets/assets/images/tik_tok_icon.png": "05a303f8eed6908d0dd944c20586057a",
"assets/assets/images/text_scan_image.png": "de42d57537f7ec6cb7825cfcc100c123",
"assets/assets/images/add_person.svg": "91263323b6a1fccb15dce2f43bff6d58",
"assets/assets/images/enhanced_performance.png": "631b122df980298662fa2bcbdff3ca37",
"assets/assets/images/google.png": "51e95b94696f9e23fd54b3b8e07650d4",
"assets/assets/images/ic_search.svg": "c98f7bad877016d7d74010974fb1700f",
"assets/assets/images/read.svg": "ab2b965d30f8528a7ca2d710e8104d15",
"assets/assets/images/facebook.png": "bb4f963b5a976f215dffc0cab0611dad",
"assets/assets/images/ic_templates.svg": "22357a9ca55abd1c37e942bc24011237",
"assets/assets/images/polygon3.png": "6c4f1d4e439c3ce83e6cf1d1a94350b7",
"assets/assets/images/ic_follow.png": "d1f2dc92125bb3ad56630c9afa19864d",
"assets/assets/images/camera.png": "9f143e2d81981e729e6813ce66fe7a04",
"assets/assets/images/pause.svg": "b705d5dde3cd66b825996606ad8d48e3",
"assets/assets/images/forward.svg": "fcd6198e790eb684339ca1799093f3d3",
"assets/assets/images/notification.png": "af69b8c35e826f6bd37aedebe295f200",
"assets/assets/images/make_money.png": "ff5de77ad7750c770c990ca2caefeec2",
"assets/assets/images/image_scan_Image.png": "14f0a6e946f48a261d3870e3819bfa17",
"assets/assets/images/ic_follow_up.png": "e329fa156eca9a59778b24a6eab2230c",
"assets/assets/images/done.svg": "d614e6cc7ae446f47976a24b780343d0",
"assets/assets/images/ic_gift.png": "9256b2972cb37e2ea303ccc8f29b1392",
"assets/assets/images/brightness2.png": "905737c70c5fa2779b895b9c49415b0e",
"assets/assets/images/scan.png": "1bd1cec13d1e088f35b789502b07bd4b",
"assets/assets/images/ic_french.png": "04615c7a309dad592ff2fd89f20d046e",
"assets/assets/images/ic_download_photo.svg": "425d706b58d0522064b2fd6fcff9aa15",
"assets/assets/images/history.svg": "4f2c1a81ea97883126fc12be28a37fd9",
"assets/assets/images/ic_close_blue.svg": "6127b1646d3487d8506078cb6732dd3b",
"assets/assets/images/Alexiuzz_GIF.gif": "71b8c60e3954271fe223027fdd30a488",
"assets/assets/images/technology.svg": "3b585ff8eb198b60676b7a2e1efffe74",
"assets/assets/images/ic_document.svg": "032bdf4f21ad3fedadbad377b3647011",
"assets/assets/videos/intro_view_video.mp4": "373aa0f29d18847064c22c06e7bdab03",
"assets/assets/fonts/appIcons.ttf": "36467176f988b7fbee107e6492f94be7",
"assets/assets/fonts/OpenSans-SemiBold.ttf": "e2ca235bf1ddc5b7a350199cf818c9c8",
"assets/assets/fonts/NeuePowerTrial-Bold.otf": "2aa81eeba1f7019cf4db7ef3dd66e107",
"assets/assets/fonts/SF-Pro-Rounded-Semibold.otf": "932b0f58cca5f6be44824f0309e65f4b",
"assets/assets/fonts/SF-Pro-Rounded-Regular.otf": "4b272a0fc4402e8ca00c55be11e5f2a4",
"assets/assets/fonts/OpenSans-Light.ttf": "c87e3b21e46c872774d041a71e181e61",
"assets/assets/fonts/SF-Pro-Text-Black.otf": "20d198c05f2252879bcf602ba9f0d35d",
"assets/assets/fonts/OpenSans-ExtraBold.ttf": "f0af8434e183f500acf62135a577c739",
"assets/assets/fonts/Helvetica-Regular.ttf": "1b580d980532792578c54897ca387e2c",
"assets/assets/fonts/Helvetica-Bold.ttf": "d13db1fed3945c3b8c3293bfcfadb32f",
"assets/assets/fonts/OpenSans-Bold.ttf": "0a191f83602623628320f3d3c667a276",
"assets/assets/fonts/NeuePowerTrial-Heavy.otf": "9f0587b422b60148b4f95589709eba8d",
"assets/assets/fonts/OpenSans-Medium.ttf": "dac0e601db6e3601159b4aae5c1fda39",
"assets/assets/fonts/Helvetica-Light.ttf": "9a8c18bd1dbe8508bc2525be7e07d0ff",
"assets/assets/fonts/OpenSans-Regular.ttf": "931aebd37b54b3e5df2fedfce1432d52",
"assets/assets/fonts/SF-Pro-Rounded-Medium.otf": "3b6aedfa70d645dcf6c902ae8b88cda4",
"assets/assets/fonts/SF-Pro-Rounded-Heavy.otf": "41a0a8607610dc7d39b9dae733deecb5",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
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
