
// // import 'package:flutter/material.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/services.dart';
// // /// Toast Length
// // /// Only for Android Platform
// // enum Toast {
// //   /// Show Short toast for 1 sec
// //   LENGTH_SHORT,

// //   /// Show Long toast for 5 sec
// //   LENGTH_LONG
// // }

// // /// ToastGravity
// // /// Used to define the position of the Toast on the screen
// // enum ToastGravity {
// //   TOP,
// //   BOTTOM,
// //   CENTER,
// //   TOP_LEFT,
// //   TOP_RIGHT,
// //   BOTTOM_LEFT,
// //   BOTTOM_RIGHT,
// //   CENTER_LEFT,
// //   CENTER_RIGHT,
// //   SNACKBAR
// // }

// // /// Plugin to show a toast message on screen
// // /// Only for android, ios and Web platforms
// // class Fluttertoast {
// //   /// [MethodChannel] used to communicate with the platform side.
// //   static const MethodChannel _channel =
// //       const MethodChannel('PonnamKarthik/fluttertoast');

// //   /// Let say you have an active show
// //   /// Use this method to hide the toast immediately
// //   static Future<bool?> cancel() async {
// //     bool? res = await _channel.invokeMethod("cancel");
// //     return res;
// //   }

// //   /// Summons the platform's showToast which will display the message
// //   ///
// //   /// Wraps the platform's native Toast for android.
// //   /// Wraps the Plugin https://github.com/scalessec/Toast for iOS
// //   /// Wraps the https://github.com/apvarun/toastify-js for Web
// //   ///
// //   /// Parameter [msg] is required and all remaining are optional
// //   static Future<bool?> showToast({
// //     required String msg,
// //     Toast? toastLength,
// //     int timeInSecForIosWeb = 1,
// //     double? fontSize,
// //     ToastGravity? gravity,
// //     Color? backgroundColor,
// //     Color? textColor,
// //     bool webShowClose = false,
// //     webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
// //     webPosition: "right",
// //   }) async {
// //     String toast = "short";
// //     if (toastLength == Toast.LENGTH_LONG) {
// //       toast = "long";
// //     }

// //     String gravityToast = "bottom";
// //     if (gravity == ToastGravity.TOP) {
// //       gravityToast = "top";
// //     } else if (gravity == ToastGravity.CENTER) {
// //       gravityToast = "center";
// //     } else {
// //       gravityToast = "bottom";
// //     }

// // //lines from 78 to 97 have been changed in order to solve issue #328
// //     if (backgroundColor == null) {
// //       backgroundColor = Colors.black;
// //     }
// //     if (textColor == null) {
// //       textColor = Colors.white;
// //     }
// //     final Map<String, dynamic> params = <String, dynamic>{
// //       'msg': msg,
// //       'length': toast,
// //       'time': timeInSecForIosWeb,
// //       'gravity': gravityToast,
// //       'bgcolor': backgroundColor != null ? backgroundColor.value : null,
// //       'iosBgcolor': backgroundColor != null ? backgroundColor.value : null,
// //       'textcolor': textColor != null ? textColor.value : null,
// //       'iosTextcolor': textColor != null ? textColor.value : null,
// //       'fontSize': fontSize,
// //       'webShowClose': webShowClose,
// //       'webBgColor': webBgColor,
// //       'webPosition': webPosition
// //     };

// //     bool? res = await _channel.invokeMethod('showToast', params);
// //     return res;
// //   }
// // }

// // /// Signature for a function to buildCustom Toast
// // typedef PositionedToastBuilder = Widget Function(
// //     BuildContext context, Widget child);

// // /// Runs on dart side this has no interaction with the Native Side
// // /// Works with all platforms just in two lines of code
// // /// final fToast = FToast().init(context)
// // /// fToast.showToast(child)
// // ///
// // class FToast {
// //   BuildContext? context;

// //   static final FToast _instance = FToast._internal();

// //   /// Prmary Constructor for FToast
// //   factory FToast() {
// //     return _instance;
// //   }

// //   /// Take users Context and saves to avariable
// //   FToast init(BuildContext context) {
// //     _instance.context = context;
// //     return _instance;
// //   }

// //   FToast._internal();

// //   OverlayEntry? _entry;
// //   List<_ToastEntry> _overlayQueue = [];
// //   Timer? _timer;

// //   /// Internal function which handles the adding
// //   /// the overlay to the screen
// //   ///
// //   _showOverlay() {
// //     if (_overlayQueue.length == 0) {
// //       _entry = null;
// //       return;
// //     }
// //     _ToastEntry _toastEntry = _overlayQueue.removeAt(0);
// //     _entry = _toastEntry.entry;
// //     if (context == null)
// //       throw ("Error: Context is null, Please call init(context) before showing toast.");
// //     Overlay.of(context!)?.insert(_entry!);

// //     _timer = Timer(_toastEntry.duration!, () {
// //       Future.delayed(Duration(milliseconds: 360), () {
// //         removeCustomToast();
// //       });
// //     });
// //   }

// //   /// If any active toast present
// //   /// call removeCustomToast to hide the toast immediately
// //   removeCustomToast() {
// //     _timer?.cancel();
// //     _timer = null;
// //     if (_entry != null) _entry!.remove();
// //     _entry = null;
// //     _showOverlay();
// //   }

// //   /// FToast maintains a queue for every toast
// //   /// if we called showToast for 3 times we all to queue
// //   /// and show them one after another
// //   ///
// //   /// call removeCustomToast to hide the toast immediately
// //   removeQueuedCustomToasts() {
// //     _timer?.cancel();
// //     _timer = null;
// //     _overlayQueue.clear();
// //     if (_entry != null) _entry!.remove();
// //     _entry = null;
// //   }

// //   /// showToast accepts all the required paramenters and prepares the child
// //   /// calls _showOverlay to display toast
// //   ///
// //   /// Paramenter [child] is requried
// //   /// fadeDuration default is 350 milliseconds
// //   void showToast({
// //     required Widget child,
// //     PositionedToastBuilder? positionedToastBuilder,
// //     Duration? toastDuration,
// //     ToastGravity? gravity,
// //     int fadeDuration = 350,
// //   }) {
// //     if (context == null)
// //       throw ("Error: Context is null, Please call init(context) before showing toast.");
// //     Widget newChild = _ToastStateFul(
// //         child, toastDuration ?? Duration(seconds: 2),
// //         fadeDuration: fadeDuration);

// //     /// Check for keyboard open
// //     /// If open will ignore the gravity bottom and change it to center
// //     if (gravity == ToastGravity.BOTTOM) {
// //       if (MediaQuery.of(context!).viewInsets.bottom != 0) {
// //         gravity = ToastGravity.CENTER;
// //       }
// //     }

// //     OverlayEntry newEntry = OverlayEntry(builder: (context) {
// //       if (positionedToastBuilder != null)
// //         return positionedToastBuilder(context, newChild);
// //       return _getPostionWidgetBasedOnGravity(newChild, gravity);
// //     });

// //     _overlayQueue.add(_ToastEntry(
// //         entry: newEntry, duration: toastDuration ?? Duration(seconds: 2)));
// //     if (_timer == null) _showOverlay();
// //   }

// //   /// _getPostionWidgetBasedOnGravity generates [Positioned] [Widget]
// //   /// based on the gravity  [ToastGravity] provided by the user in
// //   /// [showToast]
// //   _getPostionWidgetBasedOnGravity(Widget child, ToastGravity? gravity) {
// //     switch (gravity) {
// //       case ToastGravity.TOP:
// //         return Positioned(top: 100.0, left: 24.0, right: 24.0, child: child);
// //       case ToastGravity.TOP_LEFT:
// //         return Positioned(top: 100.0, left: 24.0, child: child);
// //       case ToastGravity.TOP_RIGHT:
// //         return Positioned(top: 100.0, right: 24.0, child: child);
// //       case ToastGravity.CENTER:
// //         return Positioned(
// //             top: 50.0, bottom: 50.0, left: 24.0, right: 24.0, child: child);
// //       case ToastGravity.CENTER_LEFT:
// //         return Positioned(top: 50.0, bottom: 50.0, left: 24.0, child: child);
// //       case ToastGravity.CENTER_RIGHT:
// //         return Positioned(top: 50.0, bottom: 50.0, right: 24.0, child: child);
// //       case ToastGravity.BOTTOM_LEFT:
// //         return Positioned(bottom: 50.0, left: 24.0, child: child);
// //       case ToastGravity.BOTTOM_RIGHT:
// //         return Positioned(bottom: 50.0, right: 24.0, child: child);
// //       case ToastGravity.SNACKBAR:
// //         return Positioned(
// //             bottom: MediaQuery.of(context!).viewInsets.bottom,
// //             left: 0,
// //             right: 0,
// //             child: child);
// //       case ToastGravity.BOTTOM:
// //       default:
// //         return Positioned(bottom: 50.0, left: 24.0, right: 24.0, child: child);
// //     }
// //   }
// // }

// // /// internal class [_ToastEntry] which maintains
// // /// each [OverlayEntry] and [Duration] for every toast user
// // /// triggered
// // class _ToastEntry {
// //   final OverlayEntry? entry;
// //   final Duration? duration;

// //   _ToastEntry({this.entry, this.duration});
// // }

// // /// internal [StatefulWidget] which handles the show and hide
// // /// animations for [FToast]
// // class _ToastStateFul extends StatefulWidget {
// //   _ToastStateFul(this.child, this.duration, {Key? key, this.fadeDuration = 350})
// //       : super(key: key);

// //   final Widget child;
// //   final Duration duration;
// //   final int fadeDuration;

// //   @override
// //   ToastStateFulState createState() => ToastStateFulState();
// // }

// // /// State for [_ToastStateFul]
// // class ToastStateFulState extends State<_ToastStateFul>
// //     with SingleTickerProviderStateMixin {
  
// //   /// Start the showing animations for the toast
// //   showIt() {
// //     _animationController!.forward();
// //   }

// //   /// Start the hidding animations for the toast
// //   hideIt() {
// //     _animationController!.reverse();
// //     _timer?.cancel();
// //   }

// //   /// Controller to start and hide the animation
// //   AnimationController? _animationController;
// //   late Animation _fadeAnimation;

// //   Timer? _timer;

// //   @override
// //   void initState() {
// //     _animationController = AnimationController(
// //       vsync: this,
// //       duration: Duration(milliseconds: widget().fadeDuration),
// //     );
// //     _fadeAnimation =
// //         CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
// //     super.initState();

// //     showIt();
// //     _timer = Timer(widget().duration, () {
// //       hideIt();
// //     });
// //   }

// //   @override
// //   void deactivate() {
// //     _timer?.cancel();
// //     _animationController!.stop();
// //     super.deactivate();
// //   }

// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     _animationController?.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return FadeTransition(
// //       opacity: _fadeAnimation as Animation<double>,
// //       child: Center(
// //         child: Material(
// //           color: Colors.transparent,
// //           child: widget().child,
// //         ),
// //       ),
// //     );
// //   }
// // }

// ...............................................................................


// // Copyright 2017 The Chromium Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// package io.flutter.plugins.firebase.auth;

// import static io.flutter.plugins.firebase.core.FlutterFirebasePluginRegistry.registerPlugin;

// import android.app.Activity;
// import android.net.Uri;
// import androidx.annotation.NonNull;
// import androidx.annotation.Nullable;
// import com.google.android.gms.tasks.Task;
// import com.google.android.gms.tasks.TaskCompletionSource;
// import com.google.android.gms.tasks.Tasks;
// import com.google.firebase.FirebaseApiNotAvailableException;
// import com.google.firebase.FirebaseApp;
// import com.google.firebase.FirebaseNetworkException;
// import com.google.firebase.FirebaseTooManyRequestsException;
// import com.google.firebase.auth.ActionCodeEmailInfo;
// import com.google.firebase.auth.ActionCodeInfo;
// import com.google.firebase.auth.ActionCodeResult;
// import com.google.firebase.auth.ActionCodeSettings;
// import com.google.firebase.auth.AdditionalUserInfo;
// import com.google.firebase.auth.AuthCredential;
// import com.google.firebase.auth.AuthResult;
// import com.google.firebase.auth.EmailAuthProvider;
// import com.google.firebase.auth.FacebookAuthProvider;
// import com.google.firebase.auth.FirebaseAuth;
// import com.google.firebase.auth.FirebaseAuthException;
// import com.google.firebase.auth.FirebaseAuthMultiFactorException;
// import com.google.firebase.auth.FirebaseAuthProvider;
// import com.google.firebase.auth.FirebaseUser;
// import com.google.firebase.auth.FirebaseUserMetadata;
// import com.google.firebase.auth.GetTokenResult;
// import com.google.firebase.auth.GithubAuthProvider;
// import com.google.firebase.auth.GoogleAuthProvider;
// import com.google.firebase.auth.MultiFactor;
// import com.google.firebase.auth.MultiFactorAssertion;
// import com.google.firebase.auth.MultiFactorInfo;
// import com.google.firebase.auth.MultiFactorResolver;
// import com.google.firebase.auth.MultiFactorSession;
// import com.google.firebase.auth.OAuthProvider;
// import com.google.firebase.auth.PhoneAuthCredential;
// import com.google.firebase.auth.PhoneAuthProvider;
// import com.google.firebase.auth.PhoneMultiFactorGenerator;
// import com.google.firebase.auth.PhoneMultiFactorInfo;
// import com.google.firebase.auth.SignInMethodQueryResult;
// import com.google.firebase.auth.TwitterAuthProvider;
// import com.google.firebase.auth.UserInfo;
// import com.google.firebase.auth.UserProfileChangeRequest;
// import com.google.firebase.internal.api.FirebaseNoSignedInUserException;
// import io.flutter.embedding.engine.plugins.FlutterPlugin;
// import io.flutter.embedding.engine.plugins.activity.ActivityAware;
// import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
// import io.flutter.plugin.common.BinaryMessenger;
// import io.flutter.plugin.common.EventChannel;
// import io.flutter.plugin.common.EventChannel.StreamHandler;
// import io.flutter.plugin.common.MethodCall;
// import io.flutter.plugin.common.MethodChannel;
// import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
// import io.flutter.plugin.common.MethodChannel.Result;
// import io.flutter.plugins.firebase.core.FlutterFirebasePlugin;
// import java.util.ArrayList;
// import java.util.HashMap;
// import java.util.Iterator;
// import java.util.List;
// import java.util.Map;
// import java.util.Objects;
// import java.util.UUID;
// import java.util.concurrent.ExecutionException;

// /** Flutter plugin for Firebase Auth. */
// public class FlutterFirebaseAuthPlugin
//     implements FlutterFirebasePlugin,
//         MethodCallHandler,
//         FlutterPlugin,
//         ActivityAware,
//         GeneratedAndroidFirebaseAuth.MultiFactorUserHostApi,
//         GeneratedAndroidFirebaseAuth.MultiFactoResolverHostApi {

//   private static final String METHOD_CHANNEL_NAME = "plugins.flutter.io/firebase_auth";

//   // Stores the instances of native AuthCredentials by their hashCode
//   static final HashMap<Integer, AuthCredential> authCredentials = new HashMap<>();

//   @Nullable private BinaryMessenger messenger;

//   private MethodChannel channel;
//   private Activity activity;

//   private final Map<EventChannel, StreamHandler> streamHandlers = new HashMap<>();

//   static Map<String, Object> parseAuthCredential(AuthCredential authCredential) {
//     if (authCredential == null) {
//       return null;
//     }

//     int authCredentialHashCode = authCredential.hashCode();
//     authCredentials.put(authCredentialHashCode, authCredential);

//     Map<String, Object> output = new HashMap<>();

//     output.put(Constants.PROVIDER_ID, authCredential.getProvider());
//     output.put(Constants.SIGN_IN_METHOD, authCredential.getSignInMethod());
//     output.put(Constants.TOKEN, authCredentialHashCode);

//     return output;
//   }

//   private void initInstance(BinaryMessenger messenger) {
//     registerPlugin(METHOD_CHANNEL_NAME, this);
//     channel = new MethodChannel(messenger, METHOD_CHANNEL_NAME);
//     channel.setMethodCallHandler(this);
//     GeneratedAndroidFirebaseAuth.MultiFactorUserHostApi.setup(messenger, this);
//     GeneratedAndroidFirebaseAuth.MultiFactoResolverHostApi.setup(messenger, this);

//     this.messenger = messenger;
//   }

//   @Override
//   public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
//     initInstance(binding.getBinaryMessenger());
//   }

//   @Override
//   public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
//     channel.setMethodCallHandler(null);
//     channel = null;
//     messenger = null;
//     GeneratedAndroidFirebaseAuth.MultiFactorUserHostApi.setup(binding.getBinaryMessenger(), null);
//     GeneratedAndroidFirebaseAuth.MultiFactoResolverHostApi.setup(
//         binding.getBinaryMessenger(), null);

//     removeEventListeners();
//   }

//   @Override
//   public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
//     activity = activityPluginBinding.getActivity();
//   }

//   @Override
//   public void onDetachedFromActivityForConfigChanges() {
//     activity = null;
//   }

//   @Override
//   public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
//     activity = activityPluginBinding.getActivity();
//   }

//   @Override
//   public void onDetachedFromActivity() {
//     activity = null;
//   }

//   // Only access activity with this method.
//   @Nullable
//   private Activity getActivity() {
//     return activity;
//   }

//   static FirebaseAuth getAuth(Map<String, Object> arguments) {
//     String appName = (String) Objects.requireNonNull(arguments.get(Constants.APP_NAME));
//     FirebaseApp app = FirebaseApp.getInstance(appName);
//     FirebaseAuth auth = FirebaseAuth.getInstance(app);
//     String tenantId = (String) arguments.get(Constants.TENANT_ID);
//     if (tenantId != null) {
//       auth.setTenantId(tenantId);
//     }
//     return auth;
//   }

//   private FirebaseUser getCurrentUser(Map<String, Object> arguments) {
//     String appName = (String) Objects.requireNonNull(arguments.get(Constants.APP_NAME));
//     FirebaseApp app = FirebaseApp.getInstance(appName);
//     return FirebaseAuth.getInstance(app).getCurrentUser();
//   }

//   private FirebaseUser getCurrentUser(String appName) {
//     FirebaseApp app = FirebaseApp.getInstance(appName);
//     return FirebaseAuth.getInstance(app).getCurrentUser();
//   }

//   private AuthCredential getCredential(Map<String, Object> arguments)
//       throws FlutterFirebaseAuthPluginException {
//     @SuppressWarnings("unchecked")
//     Map<String, Object> credentialMap =
//         (Map<String, Object>) Objects.requireNonNull(arguments.get(Constants.CREDENTIAL));

//     // If the credential map contains a token, it means a native one has been stored
//     if (credentialMap.get(Constants.TOKEN) != null) {
//       int token = (int) credentialMap.get(Constants.TOKEN);
//       AuthCredential credential = authCredentials.get(token);

//       if (credential == null) {
//         throw FlutterFirebaseAuthPluginException.invalidCredential();
//       }

//       return credential;
//     }

//     String signInMethod =
//         (String) Objects.requireNonNull(credentialMap.get(Constants.SIGN_IN_METHOD));
//     String secret = (String) credentialMap.get(Constants.SECRET);
//     String idToken = (String) credentialMap.get(Constants.ID_TOKEN);
//     String accessToken = (String) credentialMap.get(Constants.ACCESS_TOKEN);
//     String rawNonce = (String) credentialMap.get(Constants.RAW_NONCE);

//     switch (signInMethod) {
//       case Constants.SIGN_IN_METHOD_PASSWORD:
//         return EmailAuthProvider.getCredential(
//             (String) Objects.requireNonNull(credentialMap.get(Constants.EMAIL)),
//             Objects.requireNonNull(secret));
//       case Constants.SIGN_IN_METHOD_EMAIL_LINK:
//         return EmailAuthProvider.getCredentialWithLink(
//             (String) Objects.requireNonNull(credentialMap.get(Constants.EMAIL)),
//             (String) Objects.requireNonNull(credentialMap.get(Constants.EMAIL_LINK)));
//       case Constants.SIGN_IN_METHOD_FACEBOOK:
//         return FacebookAuthProvider.getCredential(Objects.requireNonNull(accessToken));
//       case Constants.SIGN_IN_METHOD_GOOGLE:
//         return GoogleAuthProvider.getCredential(idToken, accessToken);
//       case Constants.SIGN_IN_METHOD_TWITTER:
//         return TwitterAuthProvider.getCredential(
//             Objects.requireNonNull(accessToken), Objects.requireNonNull(secret));
//       case Constants.SIGN_IN_METHOD_GITHUB:
//         return GithubAuthProvider.getCredential(Objects.requireNonNull(accessToken));
//       case Constants.SIGN_IN_METHOD_PHONE:
//         {
//           String verificationId =
//               (String) Objects.requireNonNull(credentialMap.get(Constants.VERIFICATION_ID));
//           String smsCode = (String) Objects.requireNonNull(credentialMap.get(Constants.SMS_CODE));
//           return PhoneAuthProvider.getCredential(verificationId, smsCode);
//         }
//       case Constants.SIGN_IN_METHOD_OAUTH:
//         {
//           String providerId =
//               (String) Objects.requireNonNull(credentialMap.get(Constants.PROVIDER_ID));
//           OAuthProvider.CredentialBuilder builder = OAuthProvider.newCredentialBuilder(providerId);
//           builder.setAccessToken(Objects.requireNonNull(accessToken));
//           if (rawNonce == null) {
//             builder.setIdToken(Objects.requireNonNull(idToken));
//           } else {
//             builder.setIdTokenWithRawNonce(Objects.requireNonNull(idToken), rawNonce);
//           }

//           return builder.build();
//         }
//       default:
//         return null;
//     }
//   }

//   @SuppressWarnings("ConstantConditions")
//   private Map<String, Object> parseActionCodeResult(@NonNull ActionCodeResult actionCodeResult) {
//     Map<String, Object> output = new HashMap<>();
//     Map<String, Object> data = new HashMap<>();

//     int operation = actionCodeResult.getOperation();

//     switch (operation) {
//       case ActionCodeResult.PASSWORD_RESET:
//         output.put("operation", 1);
//         break;
//       case ActionCodeResult.VERIFY_EMAIL:
//         output.put("operation", 2);
//         break;
//       case ActionCodeResult.RECOVER_EMAIL:
//         output.put("operation", 3);
//         break;
//       case ActionCodeResult.SIGN_IN_WITH_EMAIL_LINK:
//         output.put("operation", 4);
//         break;
//       case ActionCodeResult.VERIFY_BEFORE_CHANGE_EMAIL:
//         output.put("operation", 5);
//         break;
//       case ActionCodeResult.REVERT_SECOND_FACTOR_ADDITION:
//         output.put("operation", 6);
//         break;
//       default:
//         // Unknown / Error.
//         output.put("operation", 0);
//     }

//     ActionCodeInfo actionCodeInfo = actionCodeResult.getInfo();

//     if (actionCodeInfo != null && operation == ActionCodeResult.VERIFY_EMAIL
//         || operation == ActionCodeResult.PASSWORD_RESET) {
//       data.put(Constants.EMAIL, actionCodeInfo.getEmail());
//       data.put(Constants.PREVIOUS_EMAIL, null);
//     } else if (operation == ActionCodeResult.REVERT_SECOND_FACTOR_ADDITION) {
//       data.put(Constants.EMAIL, null);
//       data.put(Constants.PREVIOUS_EMAIL, null);
//     } else if (operation == ActionCodeResult.RECOVER_EMAIL
//         || operation == ActionCodeResult.VERIFY_BEFORE_CHANGE_EMAIL) {
//       ActionCodeEmailInfo actionCodeEmailInfo =
//           (ActionCodeEmailInfo) Objects.requireNonNull(actionCodeInfo);
//       data.put(Constants.EMAIL, actionCodeEmailInfo.getEmail());
//       data.put(Constants.PREVIOUS_EMAIL, actionCodeEmailInfo.getPreviousEmail());
//     }

//     output.put("data", data);
//     return output;
//   }

//   private Map<String, Object> parseAuthResult(@NonNull AuthResult authResult) {
//     Map<String, Object> output = new HashMap<>();

//     output.put(
//         Constants.ADDITIONAL_USER_INFO,
//         parseAdditionalUserInfo(authResult.getAdditionalUserInfo()));
//     output.put(Constants.AUTH_CREDENTIAL, parseAuthCredential(authResult.getCredential()));
//     output.put(Constants.USER, parseFirebaseUser(authResult.getUser()));

//     return output;
//   }

//   private Map<String, Object> parseAdditionalUserInfo(AdditionalUserInfo additionalUserInfo) {
//     if (additionalUserInfo == null) {
//       return null;
//     }

//     Map<String, Object> output = new HashMap<>();

//     output.put(Constants.IS_NEW_USER, additionalUserInfo.isNewUser());
//     output.put(Constants.PROFILE, additionalUserInfo.getProfile());
//     output.put(Constants.PROVIDER_ID, additionalUserInfo.getProviderId());
//     output.put(Constants.USERNAME, additionalUserInfo.getUsername());

//     return output;
//   }

//   static Map<String, Object> parseFirebaseUser(FirebaseUser firebaseUser) {
//     if (firebaseUser == null) {
//       return null;
//     }

//     Map<String, Object> output = new HashMap<>();
//     Map<String, Object> metadata = new HashMap<>();

//     output.put(Constants.DISPLAY_NAME, firebaseUser.getDisplayName());
//     output.put(Constants.EMAIL, firebaseUser.getEmail());
//     output.put(Constants.EMAIL_VERIFIED, firebaseUser.isEmailVerified());
//     output.put(Constants.IS_ANONYMOUS, firebaseUser.isAnonymous());

//     // TODO(Salakar): add an integration test to check for null, if possible
//     // See https://github.com/firebase/flutterfire/issues/3643
//     final FirebaseUserMetadata userMetadata = firebaseUser.getMetadata();
//     if (userMetadata != null) {
//       metadata.put(Constants.CREATION_TIME, firebaseUser.getMetadata().getCreationTimestamp());
//       metadata.put(
//           Constants.LAST_SIGN_IN_TIME, firebaseUser.getMetadata().getLastSignInTimestamp());
//     }
//     output.put(Constants.METADATA, metadata);
//     output.put(Constants.PHONE_NUMBER, firebaseUser.getPhoneNumber());
//     output.put(Constants.PHOTO_URL, parsePhotoUrl(firebaseUser.getPhotoUrl()));
//     output.put(Constants.PROVIDER_DATA, parseUserInfoList(firebaseUser.getProviderData()));
//     output.put(Constants.REFRESH_TOKEN, ""); // native does not provide refresh tokens
//     output.put(Constants.UID, firebaseUser.getUid());
//     output.put(Constants.TENANT_ID, firebaseUser.getTenantId());

//     return output;
//   }

//   private static List<Map<String, Object>> parseUserInfoList(
//       List<? extends UserInfo> userInfoList) {
//     List<Map<String, Object>> output = new ArrayList<>();

//     Iterator<? extends UserInfo> iterator = new ArrayList<UserInfo>(userInfoList).iterator();

//     while (iterator.hasNext()) {
//       UserInfo userInfo = iterator.next();
//       if (!FirebaseAuthProvider.PROVIDER_ID.equals(userInfo.getProviderId())) {
//         output.add(parseUserInfo(userInfo));
//       }
//     }

//     return output;
//   }

//   private static Map<String, Object> parseUserInfo(@NonNull UserInfo userInfo) {
//     Map<String, Object> output = new HashMap<>();

//     output.put(Constants.DISPLAY_NAME, userInfo.getDisplayName());
//     output.put(Constants.EMAIL, userInfo.getEmail());
//     output.put(Constants.PHONE_NUMBER, userInfo.getPhoneNumber());
//     output.put(Constants.PHOTO_URL, parsePhotoUrl(userInfo.getPhotoUrl()));
//     output.put(Constants.PROVIDER_ID, userInfo.getProviderId());
//     output.put(Constants.UID, userInfo.getUid());

//     return output;
//   }

//   private static String parsePhotoUrl(Uri photoUri) {
//     if (photoUri == null) {
//       return null;
//     }

//     String photoUrl = photoUri.toString();

//     // Return null if the URL is an empty string
//     return "".equals(photoUrl) ? null : photoUrl;
//   }

//   private ActionCodeSettings getActionCodeSettings(
//       @NonNull Map<String, Object> actionCodeSettingsMap) {
//     ActionCodeSettings.Builder builder = ActionCodeSettings.newBuilder();

//     builder.setUrl((String) Objects.requireNonNull(actionCodeSettingsMap.get(Constants.URL)));

//     if (actionCodeSettingsMap.get(Constants.DYNAMIC_LINK_DOMAIN) != null) {
//       builder.setDynamicLinkDomain(
//           (String)
//               Objects.requireNonNull(actionCodeSettingsMap.get(Constants.DYNAMIC_LINK_DOMAIN)));
//     }

//     if (actionCodeSettingsMap.get(Constants.HANDLE_CODE_IN_APP) != null) {
//       builder.setHandleCodeInApp(
//           (Boolean)
//               Objects.requireNonNull(actionCodeSettingsMap.get(Constants.HANDLE_CODE_IN_APP)));
//     }

//     if (actionCodeSettingsMap.get(Constants.ANDROID) != null) {
//       @SuppressWarnings("unchecked")
//       Map<String, Object> android =
//           (Map<String, Object>)
//               Objects.requireNonNull(actionCodeSettingsMap.get(Constants.ANDROID));

//       boolean installIfNotAvailable = false;
//       if (android.get(Constants.INSTALL_APP) != null) {
//         installIfNotAvailable =
//             (Boolean) Objects.requireNonNull(android.get(Constants.INSTALL_APP));
//       }
//       String minimumVersion = null;
//       if (android.get(Constants.MINIMUM_VERSION) != null) {
//         minimumVersion = (String) android.get(Constants.MINIMUM_VERSION);
//       }

//       builder.setAndroidPackageName(
//           (String) Objects.requireNonNull(android.get(Constants.PACKAGE_NAME)),
//           installIfNotAvailable,
//           minimumVersion);
//     }

//     if (actionCodeSettingsMap.get(Constants.IOS) != null) {
//       @SuppressWarnings("unchecked")
//       Map<String, Object> iOS =
//           (Map<String, Object>) Objects.requireNonNull(actionCodeSettingsMap.get(Constants.IOS));
//       builder.setIOSBundleId((String) Objects.requireNonNull(iOS.get(Constants.BUNDLE_ID)));
//     }

//     return builder.build();
//   }

//   private Map<String, Object> parseTokenResult(@NonNull GetTokenResult tokenResult) {
//     Map<String, Object> output = new HashMap<>();

//     output.put(Constants.AUTH_TIMESTAMP, tokenResult.getAuthTimestamp() * 1000);
//     output.put(Constants.CLAIMS, tokenResult.getClaims());
//     output.put(Constants.EXPIRATION_TIMESTAMP, tokenResult.getExpirationTimestamp() * 1000);
//     output.put(Constants.ISSUED_AT_TIMESTAMP, tokenResult.getIssuedAtTimestamp() * 1000);
//     output.put(Constants.SIGN_IN_PROVIDER, tokenResult.getSignInProvider());
//     output.put(Constants.SIGN_IN_SECOND_FACTOR, tokenResult.getSignInSecondFactor());
//     output.put(Constants.TOKEN, tokenResult.getToken());

//     return output;
//   }

//   private Task<String> registerIdTokenListener(Map<String, Object> arguments) {
//     TaskCompletionSource<String> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             final FirebaseAuth auth = getAuth(arguments);
//             final IdTokenChannelStreamHandler handler = new IdTokenChannelStreamHandler(auth);
//             final String name = METHOD_CHANNEL_NAME + "/id-token/" + auth.getApp().getName();
//             final EventChannel channel = new EventChannel(messenger, name);
//             channel.setStreamHandler(handler);
//             streamHandlers.put(channel, handler);
//             taskCompletionSource.setResult(name);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<String> registerAuthStateListener(Map<String, Object> arguments) {
//     TaskCompletionSource<String> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             final FirebaseAuth auth = getAuth(arguments);
//             final AuthStateChannelStreamHandler handler = new AuthStateChannelStreamHandler(auth);
//             final String name = METHOD_CHANNEL_NAME + "/auth-state/" + auth.getApp().getName();
//             final EventChannel channel = new EventChannel(messenger, name);
//             channel.setStreamHandler(handler);
//             streamHandlers.put(channel, handler);
//             taskCompletionSource.setResult(name);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> applyActionCode(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String code = (String) Objects.requireNonNull(arguments.get(Constants.CODE));

//             Tasks.await(firebaseAuth.applyActionCode(code));
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> checkActionCode(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String code = (String) Objects.requireNonNull(arguments.get(Constants.CODE));

//             ActionCodeResult actionCodeResult = Tasks.await(firebaseAuth.checkActionCode(code));
//             taskCompletionSource.setResult(parseActionCodeResult(actionCodeResult));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> confirmPasswordReset(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String code = (String) Objects.requireNonNull(arguments.get(Constants.CODE));
//             String newPassword =
//                 (String) Objects.requireNonNull(arguments.get(Constants.NEW_PASSWORD));

//             Tasks.await(firebaseAuth.confirmPasswordReset(code, newPassword));
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> createUserWithEmailAndPassword(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String email = (String) Objects.requireNonNull(arguments.get(Constants.EMAIL));
//             String password = (String) Objects.requireNonNull(arguments.get(Constants.PASSWORD));

//             AuthResult authResult =
//                 Tasks.await(firebaseAuth.createUserWithEmailAndPassword(email, password));

//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> fetchSignInMethodsForEmail(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String email = (String) Objects.requireNonNull(arguments.get(Constants.EMAIL));

//             SignInMethodQueryResult result =
//                 Tasks.await(firebaseAuth.fetchSignInMethodsForEmail(email));

//             Map<String, Object> output = new HashMap<>();
//             output.put(Constants.PROVIDERS, result.getSignInMethods());

//             taskCompletionSource.setResult(output);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> sendPasswordResetEmail(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String email = (String) Objects.requireNonNull(arguments.get(Constants.EMAIL));
//             Object rawActionCodeSettings = arguments.get(Constants.ACTION_CODE_SETTINGS);

//             if (rawActionCodeSettings == null) {
//               Tasks.await(firebaseAuth.sendPasswordResetEmail(email));
//               taskCompletionSource.setResult(null);
//               return;
//             }

//             @SuppressWarnings("unchecked")
//             Map<String, Object> actionCodeSettings = (Map<String, Object>) rawActionCodeSettings;

//             Tasks.await(
//                 firebaseAuth.sendPasswordResetEmail(
//                     email, getActionCodeSettings(actionCodeSettings)));
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> sendSignInLinkToEmail(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String email = (String) Objects.requireNonNull(arguments.get(Constants.EMAIL));

//             @SuppressWarnings("unchecked")
//             Map<String, Object> actionCodeSettings =
//                 (Map<String, Object>)
//                     Objects.requireNonNull(arguments.get(Constants.ACTION_CODE_SETTINGS));

//             Tasks.await(
//                 firebaseAuth.sendSignInLinkToEmail(
//                     email, getActionCodeSettings(actionCodeSettings)));
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> setLanguageCode(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String languageCode = (String) arguments.get(Constants.LANGUAGE_CODE);

//             if (languageCode == null) {
//               firebaseAuth.useAppLanguage();
//             } else {
//               firebaseAuth.setLanguageCode(languageCode);
//             }

//             taskCompletionSource.setResult(
//                 new HashMap<String, Object>() {
//                   {
//                     put(Constants.LANGUAGE_CODE, firebaseAuth.getLanguageCode());
//                   }
//                 });
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> setSettings(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             Boolean appVerificationDisabledForTesting =
//                 (Boolean) arguments.get(Constants.APP_VERIFICATION_DISABLED_FOR_TESTING);
//             Boolean forceRecaptchaFlow = (Boolean) arguments.get(Constants.FORCE_RECAPTCHA_FLOW);
//             String phoneNumber = (String) arguments.get(Constants.PHONE_NUMBER);
//             String smsCode = (String) arguments.get(Constants.SMS_CODE);

//             if (appVerificationDisabledForTesting != null) {
//               firebaseAuth
//                   .getFirebaseAuthSettings()
//                   .setAppVerificationDisabledForTesting(appVerificationDisabledForTesting);
//             }

//             if (forceRecaptchaFlow != null) {
//               firebaseAuth
//                   .getFirebaseAuthSettings()
//                   .forceRecaptchaFlowForTesting(forceRecaptchaFlow);
//             }

//             if (phoneNumber != null && smsCode != null) {
//               firebaseAuth
//                   .getFirebaseAuthSettings()
//                   .setAutoRetrievedSmsCodeForPhoneNumber(phoneNumber, smsCode);
//             }

//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> signInAnonymously(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             AuthResult authResult = Tasks.await(firebaseAuth.signInAnonymously());
//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> signInWithCredential(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             AuthCredential credential = getCredential(arguments);

//             if (credential == null) {
//               throw FlutterFirebaseAuthPluginException.invalidCredential();
//             }
//             AuthResult authResult = Tasks.await(firebaseAuth.signInWithCredential(credential));
//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             if (e.getCause() instanceof FirebaseAuthMultiFactorException) {
//               handleMultiFactorException(arguments, taskCompletionSource, e);
//             } else {
//               taskCompletionSource.setException(e);
//             }
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> signInWithCustomToken(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String token = (String) Objects.requireNonNull(arguments.get(Constants.TOKEN));

//             AuthResult authResult = Tasks.await(firebaseAuth.signInWithCustomToken(token));

//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             if (e.getCause() instanceof FirebaseAuthMultiFactorException) {
//               handleMultiFactorException(arguments, taskCompletionSource, e);
//             } else {
//               taskCompletionSource.setException(e);
//             }
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> signInWithEmailAndPassword(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String email = (String) Objects.requireNonNull(arguments.get(Constants.EMAIL));
//             String password = (String) Objects.requireNonNull(arguments.get(Constants.PASSWORD));

//             AuthResult authResult =
//                 Tasks.await(firebaseAuth.signInWithEmailAndPassword(email, password));

//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             if (e.getCause() instanceof FirebaseAuthMultiFactorException) {
//               handleMultiFactorException(arguments, taskCompletionSource, e);
//             } else {
//               taskCompletionSource.setException(e);
//             }
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private void handleMultiFactorException(
//       Map<String, Object> arguments,
//       TaskCompletionSource<Map<String, Object>> taskCompletionSource,
//       Exception e) {
//     final FirebaseAuthMultiFactorException multiFactorException =
//         (FirebaseAuthMultiFactorException) e.getCause();
//     Map<String, Object> output = new HashMap<>();

//     MultiFactorResolver multiFactorResolver = multiFactorException.getResolver();
//     final List<MultiFactorInfo> hints = multiFactorResolver.getHints();

//     final MultiFactorSession session = multiFactorResolver.getSession();
//     final String sessionId = UUID.randomUUID().toString();
//     multiFactorSessionMap.put(sessionId, session);

//     final String resolverId = UUID.randomUUID().toString();
//     multiFactorResolverMap.put(resolverId, multiFactorResolver);

//     final List<Map<String, Object>> pigeonHints = multiFactorInfoToMap(hints);

//     output.put(Constants.APP_NAME, getAuth(arguments).getApp().getName());

//     output.put(Constants.MULTI_FACTOR_HINTS, pigeonHints);

//     output.put(Constants.MULTI_FACTOR_SESSION_ID, sessionId);
//     output.put(Constants.MULTI_FACTOR_RESOLVER_ID, resolverId);

//     taskCompletionSource.setException(
//         new FlutterFirebaseAuthPluginException(
//             multiFactorException.getErrorCode(),
//             multiFactorException.getLocalizedMessage(),
//             output));
//   }

//   private List<GeneratedAndroidFirebaseAuth.PigeonMultiFactorInfo> multiFactorInfoToPigeon(
//       List<MultiFactorInfo> hints) {
//     List<GeneratedAndroidFirebaseAuth.PigeonMultiFactorInfo> pigeonHints = new ArrayList<>();
//     for (MultiFactorInfo info : hints) {
//       if (info instanceof PhoneMultiFactorInfo) {
//         pigeonHints.add(
//             new GeneratedAndroidFirebaseAuth.PigeonMultiFactorInfo.Builder()
//                 .setPhoneNumber(((PhoneMultiFactorInfo) info).getPhoneNumber())
//                 .setDisplayName(info.getDisplayName())
//                 .setEnrollmentTimestamp((double) info.getEnrollmentTimestamp())
//                 .setUid(info.getUid())
//                 .setFactorId(info.getFactorId())
//                 .build());

//       } else {
//         pigeonHints.add(
//             new GeneratedAndroidFirebaseAuth.PigeonMultiFactorInfo.Builder()
//                 .setDisplayName(info.getDisplayName())
//                 .setEnrollmentTimestamp((double) info.getEnrollmentTimestamp())
//                 .setUid(info.getUid())
//                 .setFactorId(info.getFactorId())
//                 .build());
//       }
//     }
//     return pigeonHints;
//   }

//   private List<Map<String, Object>> multiFactorInfoToMap(List<MultiFactorInfo> hints) {
//     List<Map<String, Object>> pigeonHints = new ArrayList<>();
//     for (GeneratedAndroidFirebaseAuth.PigeonMultiFactorInfo info : multiFactorInfoToPigeon(hints)) {
//       pigeonHints.add(info.toMap());
//     }
//     return pigeonHints;
//   }

//   private Task<Map<String, Object>> signInWithEmailLink(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String email = (String) Objects.requireNonNull(arguments.get(Constants.EMAIL));
//             String emailLink = (String) Objects.requireNonNull(arguments.get(Constants.EMAIL_LINK));

//             AuthResult authResult = Tasks.await(firebaseAuth.signInWithEmailLink(email, emailLink));
//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             if (e.getCause() instanceof FirebaseAuthMultiFactorException) {
//               handleMultiFactorException(arguments, taskCompletionSource, e);
//             } else {
//               taskCompletionSource.setException(e);
//             }
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> signOut(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             firebaseAuth.signOut();
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> useEmulator(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String host = (String) arguments.get(Constants.HOST);
//             int port = (int) arguments.get(Constants.PORT);
//             firebaseAuth.useEmulator(host, port);
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> verifyPasswordResetCode(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String code = (String) Objects.requireNonNull(arguments.get(Constants.CODE));

//             Map<String, Object> output = new HashMap<>();
//             output.put(Constants.EMAIL, Tasks.await(firebaseAuth.verifyPasswordResetCode(code)));

//             taskCompletionSource.setResult(output);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<String> verifyPhoneNumber(Map<String, Object> arguments) {
//     TaskCompletionSource<String> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             String eventChannelName =
//                 METHOD_CHANNEL_NAME + "/phone/" + UUID.randomUUID().toString();
//             EventChannel channel = new EventChannel(messenger, eventChannelName);

//             final String multiFactorSessionId =
//                 (String) arguments.get(Constants.MULTI_FACTOR_SESSION_ID);
//             MultiFactorSession multiFactorSession = null;

//             if (multiFactorSessionId != null) {
//               multiFactorSession = multiFactorSessionMap.get(multiFactorSessionId);
//             }

//             final String multiFactorInfoId = (String) arguments.get(Constants.MULTI_FACTOR_INFO);
//             PhoneMultiFactorInfo multiFactorInfo = null;

//             if (multiFactorInfoId != null) {
//               for (String resolverId : multiFactorResolverMap.keySet()) {
//                 for (MultiFactorInfo info : multiFactorResolverMap.get(resolverId).getHints()) {
//                   if (info.getUid().equals(multiFactorInfoId)
//                       && info instanceof PhoneMultiFactorInfo) {
//                     multiFactorInfo = (PhoneMultiFactorInfo) info;
//                     break;
//                   }
//                 }
//               }
//             }

//             PhoneNumberVerificationStreamHandler handler =
//                 new PhoneNumberVerificationStreamHandler(
//                     getActivity(),
//                     arguments,
//                     multiFactorSession,
//                     multiFactorInfo,
//                     credential -> {
//                       int hashCode = credential.hashCode();
//                       authCredentials.put(hashCode, credential);
//                     });

//             channel.setStreamHandler(handler);
//             streamHandlers.put(channel, handler);

//             taskCompletionSource.setResult(eventChannelName);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> deleteUser(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             Tasks.await(firebaseUser.delete());
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> getIdToken(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);
//             Boolean forceRefresh =
//                 (Boolean) Objects.requireNonNull(arguments.get(Constants.FORCE_REFRESH));
//             Boolean tokenOnly =
//                 (Boolean) Objects.requireNonNull(arguments.get(Constants.TOKEN_ONLY));

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             GetTokenResult tokenResult = Tasks.await(firebaseUser.getIdToken(forceRefresh));

//             if (tokenOnly) {
//               Map<String, Object> output = new HashMap<>();
//               output.put("token", tokenResult.getToken());

//               taskCompletionSource.setResult(output);
//             } else {
//               taskCompletionSource.setResult(parseTokenResult(tokenResult));
//             }

//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> linkUserWithCredential(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);
//             AuthCredential credential = getCredential(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             if (credential == null) {
//               taskCompletionSource.setException(
//                   FlutterFirebaseAuthPluginException.invalidCredential());
//               return;
//             }

//             AuthResult authResult;

//             authResult = Tasks.await(firebaseUser.linkWithCredential(credential));

//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             String message = e.getMessage();

//             if (message != null
//                 && message.contains("User has already been linked to the given provider.")) {
//               taskCompletionSource.setException(
//                   FlutterFirebaseAuthPluginException.alreadyLinkedProvider());
//               return;
//             }

//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> reauthenticateUserWithCredential(
//       Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);
//             AuthCredential credential = getCredential(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             if (credential == null) {
//               taskCompletionSource.setException(
//                   FlutterFirebaseAuthPluginException.invalidCredential());
//               return;
//             }

//             AuthResult authResult =
//                 Tasks.await(firebaseUser.reauthenticateAndRetrieveData(credential));
//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> reloadUser(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             // Wait for the user to reload, and send back the updated user
//             Tasks.await(firebaseUser.reload());

//             taskCompletionSource.setResult(parseFirebaseUser(getCurrentUser(arguments)));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> sendEmailVerification(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             Object rawActionCodeSettings = arguments.get(Constants.ACTION_CODE_SETTINGS);
//             if (rawActionCodeSettings == null) {
//               Tasks.await(firebaseUser.sendEmailVerification());
//               taskCompletionSource.setResult(null);
//               return;
//             }

//             @SuppressWarnings("unchecked")
//             Map<String, Object> actionCodeSettings = (Map<String, Object>) rawActionCodeSettings;

//             Tasks.await(
//                 firebaseUser.sendEmailVerification(getActionCodeSettings(actionCodeSettings)));
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> unlinkUserProvider(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             String providerId =
//                 (String) Objects.requireNonNull(arguments.get(Constants.PROVIDER_ID));

//             AuthResult result = Tasks.await(firebaseUser.unlink(providerId));
//             taskCompletionSource.setResult(parseAuthResult(result));

//           } catch (ExecutionException e) {
//             // If the provider ID was not found an ExecutionException is thrown.
//             // On web, this is automatically handled, so we catch the specific exception here
//             // to ensure consistency.
//             taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noSuchProvider());
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> updateEmail(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             String newEmail = (String) Objects.requireNonNull(arguments.get(Constants.NEW_EMAIL));
//             Tasks.await(firebaseUser.updateEmail(newEmail));
//             Tasks.await(firebaseUser.reload());
//             taskCompletionSource.setResult(parseFirebaseUser(firebaseUser));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> updatePassword(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             String newPassword =
//                 (String) Objects.requireNonNull(arguments.get(Constants.NEW_PASSWORD));
//             Tasks.await(firebaseUser.updatePassword(newPassword));
//             Tasks.await(firebaseUser.reload());
//             taskCompletionSource.setResult(parseFirebaseUser(firebaseUser));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> updatePhoneNumber(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             PhoneAuthCredential phoneAuthCredential =
//                 (PhoneAuthCredential) getCredential(arguments);

//             if (phoneAuthCredential == null) {
//               taskCompletionSource.setException(
//                   FlutterFirebaseAuthPluginException.invalidCredential());
//               return;
//             }

//             Tasks.await(firebaseUser.updatePhoneNumber(phoneAuthCredential));
//             Tasks.await(firebaseUser.reload());
//             taskCompletionSource.setResult(parseFirebaseUser(firebaseUser));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Map<String, Object>> updateProfile(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//               return;
//             }

//             @SuppressWarnings("unchecked")
//             Map<String, String> profile =
//                 (Map<String, String>) Objects.requireNonNull(arguments.get(Constants.PROFILE));
//             UserProfileChangeRequest.Builder builder = new UserProfileChangeRequest.Builder();

//             if (profile.containsKey(Constants.DISPLAY_NAME)) {
//               String displayName = profile.get(Constants.DISPLAY_NAME);
//               builder.setDisplayName(displayName);
//             }

//             if (profile.containsKey(Constants.PHOTO_URL)) {
//               String photoURL = profile.get(Constants.PHOTO_URL);
//               if (photoURL != null) {
//                 builder.setPhotoUri(Uri.parse(photoURL));
//               } else {
//                 builder.setPhotoUri(null);
//               }
//             }

//             Tasks.await(firebaseUser.updateProfile(builder.build()));
//             Tasks.await(firebaseUser.reload());
//             taskCompletionSource.setResult(parseFirebaseUser(firebaseUser));
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private Task<Void> verifyBeforeUpdateEmail(Map<String, Object> arguments) {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseUser firebaseUser = getCurrentUser(arguments);

//             if (firebaseUser == null) {
//               taskCompletionSource.setException(FlutterFirebaseAuthPluginException.noUser());
//             }

//             String newEmail = (String) Objects.requireNonNull(arguments.get(Constants.NEW_EMAIL));
//             Object rawActionCodeSettings = arguments.get(Constants.ACTION_CODE_SETTINGS);

//             if (rawActionCodeSettings == null) {
//               Tasks.await(firebaseUser.verifyBeforeUpdateEmail(newEmail));
//               taskCompletionSource.setResult(null);
//               return;
//             }

//             @SuppressWarnings("unchecked")
//             Map<String, Object> actionCodeSettings = (Map<String, Object>) rawActionCodeSettings;

//             Tasks.await(
//                 firebaseUser.verifyBeforeUpdateEmail(
//                     newEmail, getActionCodeSettings(actionCodeSettings)));
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   @Override
//   public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
//     final Task<?> methodCallTask;

//     switch (call.method) {
//       case "Auth#registerIdTokenListener":
//         methodCallTask = registerIdTokenListener(call.arguments());
//         break;
//       case "Auth#registerAuthStateListener":
//         methodCallTask = registerAuthStateListener(call.arguments());
//         break;
//       case "Auth#applyActionCode":
//         methodCallTask = applyActionCode(call.arguments());
//         break;
//       case "Auth#checkActionCode":
//         methodCallTask = checkActionCode(call.arguments());
//         break;
//       case "Auth#confirmPasswordReset":
//         methodCallTask = confirmPasswordReset(call.arguments());
//         break;
//       case "Auth#createUserWithEmailAndPassword":
//         methodCallTask = createUserWithEmailAndPassword(call.arguments());
//         break;
//       case "Auth#fetchSignInMethodsForEmail":
//         methodCallTask = fetchSignInMethodsForEmail(call.arguments());
//         break;
//       case "Auth#sendPasswordResetEmail":
//         methodCallTask = sendPasswordResetEmail(call.arguments());
//         break;
//       case "Auth#sendSignInLinkToEmail":
//         methodCallTask = sendSignInLinkToEmail(call.arguments());
//         break;
//       case "Auth#signInWithCredential":
//         methodCallTask = signInWithCredential(call.arguments());
//         break;
//       case "Auth#setLanguageCode":
//         methodCallTask = setLanguageCode(call.arguments());
//         break;
//       case "Auth#setSettings":
//         methodCallTask = setSettings(call.arguments());
//         break;
//       case "Auth#signInAnonymously":
//         methodCallTask = signInAnonymously(call.arguments());
//         break;
//       case "Auth#signInWithCustomToken":
//         methodCallTask = signInWithCustomToken(call.arguments());
//         break;
//       case "Auth#signInWithEmailAndPassword":
//         methodCallTask = signInWithEmailAndPassword(call.arguments());
//         break;
//       case "Auth#signInWithEmailLink":
//         methodCallTask = signInWithEmailLink(call.arguments());
//         break;
//       case "Auth#signOut":
//         methodCallTask = signOut(call.arguments());
//         break;
//       case "Auth#useEmulator":
//         methodCallTask = useEmulator(call.arguments());
//         break;
//       case "Auth#verifyPasswordResetCode":
//         methodCallTask = verifyPasswordResetCode(call.arguments());
//         break;
//       case "Auth#verifyPhoneNumber":
//         methodCallTask = verifyPhoneNumber(call.arguments());
//         break;
//       case "Auth#signInWithAuthProvider":
//         methodCallTask = signInWithAuthProvider(call.arguments());
//         break;
//       case "User#delete":
//         methodCallTask = deleteUser(call.arguments());
//         break;
//       case "User#getIdToken":
//         methodCallTask = getIdToken(call.arguments());
//         break;
//       case "User#linkWithCredential":
//         methodCallTask = linkUserWithCredential(call.arguments());
//         break;
//       case "User#reauthenticateUserWithCredential":
//         methodCallTask = reauthenticateUserWithCredential(call.arguments());
//         break;
//       case "User#reload":
//         methodCallTask = reloadUser(call.arguments());
//         break;
//       case "User#sendEmailVerification":
//         methodCallTask = sendEmailVerification(call.arguments());
//         break;
//       case "User#unlink":
//         methodCallTask = unlinkUserProvider(call.arguments());
//         break;
//       case "User#updateEmail":
//         methodCallTask = updateEmail(call.arguments());
//         break;
//       case "User#updatePassword":
//         methodCallTask = updatePassword(call.arguments());
//         break;
//       case "User#updatePhoneNumber":
//         methodCallTask = updatePhoneNumber(call.arguments());
//         break;
//       case "User#updateProfile":
//         methodCallTask = updateProfile(call.arguments());
//         break;
//       case "User#verifyBeforeUpdateEmail":
//         methodCallTask = verifyBeforeUpdateEmail(call.arguments());
//         break;
//       default:
//         result.notImplemented();
//         return;
//     }

//     methodCallTask.addOnCompleteListener(
//         task -> {
//           if (task.isSuccessful()) {
//             result.success(task.getResult());
//           } else {
//             Exception exception = task.getException();
//             result.error(
//                 "firebase_auth",
//                 exception != null ? exception.getMessage() : null,
//                 getExceptionDetails(exception));
//           }
//         });
//   }

//   private Task<Map<String, Object>> signInWithAuthProvider(Map<String, Object> arguments) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             FirebaseAuth firebaseAuth = getAuth(arguments);
//             String providerId =
//                 (String) Objects.requireNonNull(arguments.get(Constants.SIGN_IN_PROVIDER));
//             List<String> scopes = (List<String>) arguments.get(Constants.SIGN_IN_PROVIDER_SCOPE);
//             Map<String, String> customParameters =
//                 (Map<String, String>) arguments.get(Constants.SIGN_IN_PROVIDER_CUSTOM_PARAMETERS);

//             OAuthProvider.Builder provider = OAuthProvider.newBuilder(providerId);
//             if (scopes != null) {
//               provider.setScopes(scopes);
//             }
//             if (customParameters != null) {
//               provider.addCustomParameters(customParameters);
//             }

//             AuthResult authResult =
//                 Tasks.await(
//                     firebaseAuth.startActivityForSignInWithProvider(
//                         /* activity= */ activity, provider.build()));
//             taskCompletionSource.setResult(parseAuthResult(authResult));
//           } catch (Exception e) {
//             if (e.getCause() instanceof FirebaseAuthMultiFactorException) {
//               handleMultiFactorException(arguments, taskCompletionSource, e);
//             } else {
//               taskCompletionSource.setException(e);
//             }
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   @Override
//   public Task<Map<String, Object>> getPluginConstantsForFirebaseApp(FirebaseApp firebaseApp) {
//     TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             Map<String, Object> constants = new HashMap<>();
//             FirebaseAuth firebaseAuth = FirebaseAuth.getInstance(firebaseApp);
//             FirebaseUser firebaseUser = firebaseAuth.getCurrentUser();
//             String languageCode = firebaseAuth.getLanguageCode();

//             Map<String, Object> user =
//                 firebaseUser == null ? null : parseFirebaseUser(firebaseUser);

//             if (languageCode != null) {
//               constants.put("APP_LANGUAGE_CODE", languageCode);
//             }

//             if (user != null) {
//               constants.put("APP_CURRENT_USER", user);
//             }

//             taskCompletionSource.setResult(constants);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   static Map<String, Object> getExceptionDetails(Exception exception) {
//     Map<String, Object> details = new HashMap<>();

//     if (exception == null) {
//       return details;
//     }

//     FlutterFirebaseAuthPluginException authException = null;

//     if (exception instanceof FirebaseAuthException) {
//       authException = new FlutterFirebaseAuthPluginException(exception, exception.getCause());
//     } else if (exception.getCause() != null
//         && exception.getCause() instanceof FirebaseAuthException) {
//       authException =
//           new FlutterFirebaseAuthPluginException(
//               (FirebaseAuthException) exception.getCause(),
//               exception.getCause().getCause() != null
//                   ? exception.getCause().getCause()
//                   : exception.getCause());
//     } else if (exception instanceof FlutterFirebaseAuthPluginException) {
//       authException = (FlutterFirebaseAuthPluginException) exception;
//     }

//     if (authException != null) {
//       details.put("code", authException.getCode());
//       details.put("message", authException.getMessage());
//       details.put("additionalData", authException.getAdditionalData());
//       return details;
//     }

//     if (exception instanceof FirebaseNetworkException
//         || (exception.getCause() != null
//             && exception.getCause() instanceof FirebaseNetworkException)) {
//       details.put("code", "network-request-failed");
//       details.put(
//           "message",
//           "A network error (such as timeout, interrupted connection or unreachable host) has occurred.");
//       details.put("additionalData", new HashMap<>());
//       return details;
//     }

//     if (exception instanceof FirebaseApiNotAvailableException
//         || (exception.getCause() != null
//             && exception.getCause() instanceof FirebaseApiNotAvailableException)) {
//       details.put("code", "api-not-available");
//       details.put("message", "The requested API is not available.");
//       details.put("additionalData", new HashMap<>());
//       return details;
//     }

//     if (exception instanceof FirebaseTooManyRequestsException
//         || (exception.getCause() != null
//             && exception.getCause() instanceof FirebaseTooManyRequestsException)) {
//       details.put("code", "too-many-requests");
//       details.put(
//           "message",
//           "We have blocked all requests from this device due to unusual activity. Try again later.");
//       details.put("additionalData", new HashMap<>());
//       return details;
//     }

//     // Manual message overrides to match other platforms.
//     if (exception.getMessage() != null
//         && exception
//             .getMessage()
//             .startsWith("Cannot create PhoneAuthCredential without either verificationProof")) {
//       details.put("code", "invalid-verification-id");
//       details.put(
//           "message", "The verification ID used to create the phone auth credential is invalid.");
//       details.put("additionalData", new HashMap<>());
//       return details;
//     }

//     return details;
//   }

//   @Override
//   public Task<Void> didReinitializeFirebaseCore() {
//     TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

//     cachedThreadPool.execute(
//         () -> {
//           try {
//             removeEventListeners();
//             authCredentials.clear();
//             taskCompletionSource.setResult(null);
//           } catch (Exception e) {
//             taskCompletionSource.setException(e);
//           }
//         });

//     return taskCompletionSource.getTask();
//   }

//   private void removeEventListeners() {
//     for (EventChannel eventChannel : streamHandlers.keySet()) {
//       StreamHandler streamHandler = streamHandlers.get(eventChannel);
//       streamHandler.onCancel(null);
//       eventChannel.setStreamHandler(null);
//     }
//     streamHandlers.clear();
//   }

//   // Map an app id to a map of user id to a MultiFactorUser object.
//   private final Map<String, Map<String, MultiFactor>> multiFactorUserMap = new HashMap<>();

//   // Map an id to a MultiFactorSession object.
//   private final Map<String, MultiFactorSession> multiFactorSessionMap = new HashMap<>();

//   // Map an id to a MultiFactorSession object.
//   private final Map<String, MultiFactorResolver> multiFactorResolverMap = new HashMap<>();

//   private MultiFactor getAppMultiFactor(@NonNull String appName)
//       throws FirebaseNoSignedInUserException {
//     final FirebaseUser currentUser = getCurrentUser(appName);
//     if (currentUser == null) {
//       throw new FirebaseNoSignedInUserException("No user is signed in");
//     }
//     if (multiFactorUserMap.get(appName) == null) {
//       multiFactorUserMap.put(appName, new HashMap<>());
//     }

//     final Map<String, MultiFactor> appMultiFactorUser = multiFactorUserMap.get(appName);
//     if (appMultiFactorUser.get(currentUser.getUid()) == null) {
//       appMultiFactorUser.put(currentUser.getUid(), currentUser.getMultiFactor());
//     }

//     final MultiFactor multiFactor = appMultiFactorUser.get(currentUser.getUid());
//     return multiFactor;
//   }

//   @Override
//   public void enrollPhone(
//       @NonNull String appName,
//       @NonNull GeneratedAndroidFirebaseAuth.PigeonPhoneMultiFactorAssertion assertion,
//       @Nullable String displayName,
//       GeneratedAndroidFirebaseAuth.Result<Void> result) {
//     final MultiFactor multiFactor;
//     try {
//       multiFactor = getAppMultiFactor(appName);
//     } catch (FirebaseNoSignedInUserException e) {
//       result.error(e);
//       return;
//     }

//     PhoneAuthCredential credential =
//         PhoneAuthProvider.getCredential(
//             assertion.getVerificationId(), assertion.getVerificationCode());

//     MultiFactorAssertion multiFactorAssertion = PhoneMultiFactorGenerator.getAssertion(credential);

//     multiFactor
//         .enroll(multiFactorAssertion, displayName)
//         .addOnCompleteListener(
//             task -> {
//               if (task.isSuccessful()) {
//                 result.success(null);
//               } else {
//                 result.error(task.getException());
//               }
//             });
//   }

//   @Override
//   public void getSession(
//       @NonNull String appName,
//       GeneratedAndroidFirebaseAuth.Result<GeneratedAndroidFirebaseAuth.PigeonMultiFactorSession>
//           result) {
//     final MultiFactor multiFactor;
//     try {
//       multiFactor = getAppMultiFactor(appName);
//     } catch (FirebaseNoSignedInUserException e) {
//       result.error(e);
//       return;
//     }

//     multiFactor
//         .getSession()
//         .addOnCompleteListener(
//             task -> {
//               if (task.isSuccessful()) {
//                 final MultiFactorSession sessionResult = task.getResult();
//                 final String id = UUID.randomUUID().toString();
//                 multiFactorSessionMap.put(id, sessionResult);
//                 result.success(
//                     new GeneratedAndroidFirebaseAuth.PigeonMultiFactorSession.Builder()
//                         .setId(id)
//                         .build());
//               } else {
//                 Exception exception = task.getException();
//                 result.error(exception);
//               }
//             });
//   }

//   @Override
//   public void unenroll(
//       @NonNull String appName,
//       @Nullable String factorUid,
//       GeneratedAndroidFirebaseAuth.Result<Void> result) {
//     final MultiFactor multiFactor;
//     try {
//       multiFactor = getAppMultiFactor(appName);
//     } catch (FirebaseNoSignedInUserException e) {
//       result.error(e);
//       return;
//     }

//     multiFactor
//         .unenroll(factorUid)
//         .addOnCompleteListener(
//             task -> {
//               if (task.isSuccessful()) {
//                 result.success(null);
//               } else {
//                 result.error(task.getException());
//               }
//             });
//   }

//   @Override
//   public void getEnrolledFactors(
//       @NonNull String appName,
//       GeneratedAndroidFirebaseAuth.Result<List<GeneratedAndroidFirebaseAuth.PigeonMultiFactorInfo>>
//           result) {
//     final MultiFactor multiFactor;
//     try {
//       multiFactor = getAppMultiFactor(appName);
//     } catch (FirebaseNoSignedInUserException e) {
//       result.error(e);
//       return;
//     }

//     final List<MultiFactorInfo> factors = multiFactor.getEnrolledFactors();

//     final List<GeneratedAndroidFirebaseAuth.PigeonMultiFactorInfo> resultFactors =
//         multiFactorInfoToPigeon(factors);

//     result.success(resultFactors);
//   }

//   @Override
//   public void resolveSignIn(
//       @NonNull String resolverId,
//       @NonNull GeneratedAndroidFirebaseAuth.PigeonPhoneMultiFactorAssertion assertion,
//       GeneratedAndroidFirebaseAuth.Result<Map<String, Object>> result) {
//     final MultiFactorResolver resolver = multiFactorResolverMap.get(resolverId);

//     PhoneAuthCredential credential =
//         PhoneAuthProvider.getCredential(
//             assertion.getVerificationId(), assertion.getVerificationCode());

//     MultiFactorAssertion multiFactorAssertion = PhoneMultiFactorGenerator.getAssertion(credential);

//     resolver
//         .resolveSignIn(multiFactorAssertion)
//         .addOnCompleteListener(
//             task -> {
//               if (task.isSuccessful()) {
//                 final AuthResult authResult = task.getResult();
//                 result.success(parseAuthResult(authResult));
//               } else {
//                 Exception exception = task.getException();
//                 result.error(exception);
//               }
//             });
//   }
// }
//  .....................................................................


// bool result=false;

// final googleSignIn=GoogleSignIn();
// final googleAccount=await googleSignIn.signIn();
// if(googleAccount!=null){
//   final googleAuth=await googleAccount.authentication;
//   if(googleAuth.accessToken!=null && googleAuth.idToken!=null){
//     try{
//       // final user=auth.currentUser;
//         // final u_id=user!.uid;
//       UserCredential userCredential= await auth.signInWithCredential(
//         GoogleAuthProvider.credential(idToken: googleAuth.idToken,accessToken: googleAuth.accessToken));
//         User? user=userCredential.user;

//         if(user!=null){
//           if(userCredential.additionalUserInfo!.isNewUser){
//             await FirebaseFirestore.instance.collection('users').doc(uid).set({
//           'id': uid,
//           'name': auth.currentUser!.displayName,
//           'email': auth.currentUser!.email, 
//           'photo-url': auth.currentUser!.photoURL,
//           'createdAt': Timestamp.now()
//           });
//           }
//           result=true;
//         // MaterialPageRoute(builder: ((context) => HomeScreen()));
//         }
//         return result;
        
//     }

  

  // if(user?.providerData[0].providerId=="google.com")