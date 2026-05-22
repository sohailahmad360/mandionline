import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ur'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Mandi Online'**
  String get appTitle;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get splashLoading;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboardingTitle;

  /// No description provided for @tradesTitle.
  ///
  /// In en, this message translates to:
  /// **'Trades'**
  String get tradesTitle;

  /// No description provided for @dealsTitle.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get dealsTitle;

  /// No description provided for @messagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @loginErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'That email or password does not match the demo account. Use the exact values shown above, or tap Login as Guest.'**
  String get loginErrorInvalidCredentials;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to your trading floor'**
  String get loginSubtitle;

  /// No description provided for @loginDemoCredentials.
  ///
  /// In en, this message translates to:
  /// **'Demo: {email} · {password}'**
  String loginDemoCredentials(String email, String password);

  /// No description provided for @emailOrPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Email or phone'**
  String get emailOrPhoneLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Forgot password — coming soon'**
  String get forgotPasswordComingSoon;

  /// No description provided for @signInCta.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInCta;

  /// No description provided for @loginAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Login as Guest'**
  String get loginAsGuest;

  /// No description provided for @languageSwitchToUrdu.
  ///
  /// In en, this message translates to:
  /// **'اردو'**
  String get languageSwitchToUrdu;

  /// No description provided for @languageSwitchToEnglish.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get languageSwitchToEnglish;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTrades.
  ///
  /// In en, this message translates to:
  /// **'Trades'**
  String get navTrades;

  /// No description provided for @navDeals.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get navDeals;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @drawerGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get drawerGuest;

  /// No description provided for @drawerMemberDefault.
  ///
  /// In en, this message translates to:
  /// **'Mandi member'**
  String get drawerMemberDefault;

  /// No description provided for @drawerUserDefault.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get drawerUserDefault;

  /// No description provided for @drawerBrowsingGuest.
  ///
  /// In en, this message translates to:
  /// **'Browsing as guest'**
  String get drawerBrowsingGuest;

  /// No description provided for @drawerSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get drawerSignedIn;

  /// No description provided for @drawerProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get drawerProfile;

  /// No description provided for @drawerSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettings;

  /// No description provided for @drawerOrderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get drawerOrderHistory;

  /// No description provided for @drawerHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get drawerHelp;

  /// No description provided for @drawerLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get drawerLogout;

  /// No description provided for @comingSoonProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile — coming soon'**
  String get comingSoonProfile;

  /// No description provided for @comingSoonSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings — coming soon'**
  String get comingSoonSettings;

  /// No description provided for @comingSoonHistory.
  ///
  /// In en, this message translates to:
  /// **'History — coming soon'**
  String get comingSoonHistory;

  /// No description provided for @comingSoonSupport.
  ///
  /// In en, this message translates to:
  /// **'Support — coming soon'**
  String get comingSoonSupport;

  /// No description provided for @comingSoonCreateTrade.
  ///
  /// In en, this message translates to:
  /// **'Create trade — coming soon'**
  String get comingSoonCreateTrade;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning 👋'**
  String get greetingMorning;

  /// No description provided for @guestHomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Browse categories & live offers'**
  String get guestHomeSubtitle;

  /// No description provided for @demoStoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Punjabi Store · Lahore'**
  String get demoStoreSubtitle;

  /// No description provided for @demoProfileName.
  ///
  /// In en, this message translates to:
  /// **'Azhar Iqbal Awan'**
  String get demoProfileName;

  /// No description provided for @searchHintHome.
  ///
  /// In en, this message translates to:
  /// **'Search spices, nuts, dry fruits…'**
  String get searchHintHome;

  /// No description provided for @dashboardStatTrades.
  ///
  /// In en, this message translates to:
  /// **'Trades'**
  String get dashboardStatTrades;

  /// No description provided for @dashboardStatDeals.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get dashboardStatDeals;

  /// No description provided for @dashboardStatLedgers.
  ///
  /// In en, this message translates to:
  /// **'Ledgers'**
  String get dashboardStatLedgers;

  /// No description provided for @dashboardStatActiveOffers.
  ///
  /// In en, this message translates to:
  /// **'Active offers'**
  String get dashboardStatActiveOffers;

  /// No description provided for @sectionTopCategories.
  ///
  /// In en, this message translates to:
  /// **'Top categories'**
  String get sectionTopCategories;

  /// No description provided for @sectionLiveOffers.
  ///
  /// In en, this message translates to:
  /// **'Live offers'**
  String get sectionLiveOffers;

  /// No description provided for @sectionRecentTrades.
  ///
  /// In en, this message translates to:
  /// **'Recent trades'**
  String get sectionRecentTrades;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @categorySpices.
  ///
  /// In en, this message translates to:
  /// **'Spices'**
  String get categorySpices;

  /// No description provided for @categoryDryFruits.
  ///
  /// In en, this message translates to:
  /// **'Dry fruits'**
  String get categoryDryFruits;

  /// No description provided for @categoryNuts.
  ///
  /// In en, this message translates to:
  /// **'Nuts'**
  String get categoryNuts;

  /// No description provided for @categoryHerbs.
  ///
  /// In en, this message translates to:
  /// **'Herbs'**
  String get categoryHerbs;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(int count);

  /// No description provided for @tradeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load trades'**
  String get tradeLoadError;

  /// No description provided for @noTradesYet.
  ///
  /// In en, this message translates to:
  /// **'No trades yet'**
  String get noTradesYet;

  /// No description provided for @offerCategoryPakistan.
  ///
  /// In en, this message translates to:
  /// **'Spices · Pakistan'**
  String get offerCategoryPakistan;

  /// No description provided for @offerCategoryGuatemala.
  ///
  /// In en, this message translates to:
  /// **'Spices · Guatemala'**
  String get offerCategoryGuatemala;

  /// No description provided for @offerCategoryIndia.
  ///
  /// In en, this message translates to:
  /// **'Spices · India'**
  String get offerCategoryIndia;

  /// No description provided for @productDriedRedChilies.
  ///
  /// In en, this message translates to:
  /// **'Dried red chilies'**
  String get productDriedRedChilies;

  /// No description provided for @productGreenCardamom.
  ///
  /// In en, this message translates to:
  /// **'Green cardamom'**
  String get productGreenCardamom;

  /// No description provided for @productTurmericPowder.
  ///
  /// In en, this message translates to:
  /// **'Turmeric powder'**
  String get productTurmericPowder;

  /// No description provided for @productBlackPepper.
  ///
  /// In en, this message translates to:
  /// **'Black pepper (whole)'**
  String get productBlackPepper;

  /// No description provided for @productCinnamonSticks.
  ///
  /// In en, this message translates to:
  /// **'Cinnamon sticks'**
  String get productCinnamonSticks;

  /// No description provided for @productClovesWhole.
  ///
  /// In en, this message translates to:
  /// **'Cloves (whole)'**
  String get productClovesWhole;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// No description provided for @unitPerKg.
  ///
  /// In en, this message translates to:
  /// **'/kg'**
  String get unitPerKg;

  /// No description provided for @tradeBadgeSelling.
  ///
  /// In en, this message translates to:
  /// **'SELLING'**
  String get tradeBadgeSelling;

  /// No description provided for @tradeBadgeBuying.
  ///
  /// In en, this message translates to:
  /// **'BUYING'**
  String get tradeBadgeBuying;

  /// No description provided for @tradesScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your buying & selling trades'**
  String get tradesScreenSubtitle;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterBuying.
  ///
  /// In en, this message translates to:
  /// **'Buying'**
  String get filterBuying;

  /// No description provided for @filterSelling.
  ///
  /// In en, this message translates to:
  /// **'Selling'**
  String get filterSelling;

  /// No description provided for @filterButton.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterButton;

  /// No description provided for @browseProducts.
  ///
  /// In en, this message translates to:
  /// **'Browse products'**
  String get browseProducts;

  /// No description provided for @browseRegionPakistan.
  ///
  /// In en, this message translates to:
  /// **'Pakistan'**
  String get browseRegionPakistan;

  /// No description provided for @browseRegionGuatemala.
  ///
  /// In en, this message translates to:
  /// **'Guatemala'**
  String get browseRegionGuatemala;

  /// No description provided for @dealsScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Active and completed transactions'**
  String get dealsScreenSubtitle;

  /// No description provided for @dealSellingSummary.
  ///
  /// In en, this message translates to:
  /// **'My selling deals'**
  String get dealSellingSummary;

  /// No description provided for @dealBuyingSummary.
  ///
  /// In en, this message translates to:
  /// **'My buying deals'**
  String get dealBuyingSummary;

  /// No description provided for @paymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentLabel;

  /// No description provided for @shippingLabel.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shippingLabel;

  /// No description provided for @invoiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoiceLabel;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get statusUnpaid;

  /// No description provided for @statusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get statusDelivered;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @downloadInvoice.
  ///
  /// In en, this message translates to:
  /// **'Download invoice'**
  String get downloadInvoice;

  /// No description provided for @dealMessagesButton.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get dealMessagesButton;

  /// No description provided for @raiseDispute.
  ///
  /// In en, this message translates to:
  /// **'Raise dispute'**
  String get raiseDispute;

  /// No description provided for @messagesScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Direct messages on your trades & deals'**
  String get messagesScreenSubtitle;

  /// No description provided for @tabSelling.
  ///
  /// In en, this message translates to:
  /// **'Selling'**
  String get tabSelling;

  /// No description provided for @tabBuying.
  ///
  /// In en, this message translates to:
  /// **'Buying'**
  String get tabBuying;

  /// No description provided for @chatHeaderDeal.
  ///
  /// In en, this message translates to:
  /// **'Deal #m1'**
  String get chatHeaderDeal;

  /// No description provided for @chatParticipantSample.
  ///
  /// In en, this message translates to:
  /// **'Karachi Wholesale'**
  String get chatParticipantSample;

  /// No description provided for @chatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message…'**
  String get chatInputHint;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get genericError;

  /// No description provided for @screenProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get screenProfileTitle;

  /// No description provided for @screenSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get screenSettingsTitle;

  /// No description provided for @screenOrderHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get screenOrderHistoryTitle;

  /// No description provided for @screenHelpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get screenHelpSupportTitle;

  /// No description provided for @profileGuestBanner.
  ///
  /// In en, this message translates to:
  /// **'You are browsing as a guest. Sign in to sync your profile and orders.'**
  String get profileGuestBanner;

  /// No description provided for @profileSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileSectionAccount;

  /// No description provided for @profileLabelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileLabelEmail;

  /// No description provided for @profileEmailGuestPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Available after sign-in'**
  String get profileEmailGuestPlaceholder;

  /// No description provided for @profileLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get profileLabelPhone;

  /// No description provided for @profileDemoPhone.
  ///
  /// In en, this message translates to:
  /// **'+92 300 0000000'**
  String get profileDemoPhone;

  /// No description provided for @profileStoreRole.
  ///
  /// In en, this message translates to:
  /// **'Verified store'**
  String get profileStoreRole;

  /// No description provided for @profileEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditProfile;

  /// No description provided for @profileEditComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Profile editing will be available in a future update.'**
  String get profileEditComingSoon;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Trade alerts and deal updates'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsEmailDigest.
  ///
  /// In en, this message translates to:
  /// **'Weekly email digest'**
  String get settingsEmailDigest;

  /// No description provided for @settingsEmailDigestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Summary of your mandi activity'**
  String get settingsEmailDigestSubtitle;

  /// No description provided for @settingsAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get settingsAppLanguage;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageUrdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get settingsLanguageUrdu;

  /// No description provided for @orderHistoryPlaced.
  ///
  /// In en, this message translates to:
  /// **'Placed'**
  String get orderHistoryPlaced;

  /// No description provided for @orderHistoryOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderHistoryOrder;

  /// No description provided for @orderStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get orderStatusProcessing;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @helpContactSection.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get helpContactSection;

  /// No description provided for @helpSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'support@mandionline.pk'**
  String get helpSupportEmail;

  /// No description provided for @helpSupportPhone.
  ///
  /// In en, this message translates to:
  /// **'+92 800 000 0000'**
  String get helpSupportPhone;

  /// No description provided for @helpFaqOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'How do I track an order?'**
  String get helpFaqOrdersTitle;

  /// No description provided for @helpFaqOrdersBody.
  ///
  /// In en, this message translates to:
  /// **'Open Order history from the menu. Each row shows status and you can open the deal for shipment details.'**
  String get helpFaqOrdersBody;

  /// No description provided for @helpFaqPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'When is payment captured?'**
  String get helpFaqPaymentsTitle;

  /// No description provided for @helpFaqPaymentsBody.
  ///
  /// In en, this message translates to:
  /// **'Funds are held in escrow until delivery is confirmed by both parties. This is a demo app — no real payments occur.'**
  String get helpFaqPaymentsBody;

  /// No description provided for @helpFaqDisputesTitle.
  ///
  /// In en, this message translates to:
  /// **'How do I raise a dispute?'**
  String get helpFaqDisputesTitle;

  /// No description provided for @helpFaqDisputesBody.
  ///
  /// In en, this message translates to:
  /// **'From a deal card, use Raise dispute. Our team will review within two business days (demo only).'**
  String get helpFaqDisputesBody;

  /// No description provided for @listDetailOffersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All live listings in this demo catalog'**
  String get listDetailOffersSubtitle;

  /// No description provided for @helpFaqHeading.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get helpFaqHeading;

  /// No description provided for @snackCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get snackCopiedToClipboard;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notificationsEmpty;

  /// No description provided for @notifDealUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Deal updated'**
  String get notifDealUpdateTitle;

  /// No description provided for @notifDealUpdateBody.
  ///
  /// In en, this message translates to:
  /// **'Your deal #4521 status changed to completed.'**
  String get notifDealUpdateBody;

  /// No description provided for @notifNewMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'New message'**
  String get notifNewMessageTitle;

  /// No description provided for @notifNewMessageBody.
  ///
  /// In en, this message translates to:
  /// **'Karachi Wholesale sent a message on trade #4587.'**
  String get notifNewMessageBody;

  /// No description provided for @notifPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment received'**
  String get notifPaymentTitle;

  /// No description provided for @notifPaymentBody.
  ///
  /// In en, this message translates to:
  /// **'Rs 168,000 was credited for deal #4500.'**
  String get notifPaymentBody;

  /// No description provided for @notifShipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Shipment on the way'**
  String get notifShipmentTitle;

  /// No description provided for @notifShipmentBody.
  ///
  /// In en, this message translates to:
  /// **'Carrier picked up your order ORD-24089.'**
  String get notifShipmentBody;

  /// No description provided for @notifReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly summary'**
  String get notifReminderTitle;

  /// No description provided for @notifReminderBody.
  ///
  /// In en, this message translates to:
  /// **'You have 3 active trades and 2 open deals this week.'**
  String get notifReminderBody;

  /// No description provided for @createTradeTitle.
  ///
  /// In en, this message translates to:
  /// **'New Trade'**
  String get createTradeTitle;

  /// No description provided for @createTradeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a buying or selling trade in 4 steps'**
  String get createTradeSubtitle;

  /// No description provided for @createTradeSide.
  ///
  /// In en, this message translates to:
  /// **'Side'**
  String get createTradeSide;

  /// No description provided for @createTradeBuying.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get createTradeBuying;

  /// No description provided for @createTradeSelling.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get createTradeSelling;

  /// No description provided for @createTradeProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get createTradeProduct;

  /// No description provided for @createTradeTrader.
  ///
  /// In en, this message translates to:
  /// **'Counterparty / trader'**
  String get createTradeTrader;

  /// No description provided for @createTradeQty.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get createTradeQty;

  /// No description provided for @createTradePrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get createTradePrice;

  /// No description provided for @createTradeSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create trade'**
  String get createTradeSubmit;

  /// No description provided for @createTradeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Trade created'**
  String get createTradeSuccess;

  /// No description provided for @createTradeProductHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Dried red chilies'**
  String get createTradeProductHint;

  /// No description provided for @createTradeTraderHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Karachi Wholesale'**
  String get createTradeTraderHint;

  /// No description provided for @createTradeQtyHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 500 kg'**
  String get createTradeQtyHint;

  /// No description provided for @createTradePriceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Rs 390,000'**
  String get createTradePriceHint;

  /// No description provided for @newTradeBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get newTradeBack;

  /// No description provided for @newTradeNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get newTradeNext;

  /// No description provided for @newTradePublish.
  ///
  /// In en, this message translates to:
  /// **'Publish trade'**
  String get newTradePublish;

  /// No description provided for @newTradeStep1.
  ///
  /// In en, this message translates to:
  /// **'Step 1'**
  String get newTradeStep1;

  /// No description provided for @newTradeStep2.
  ///
  /// In en, this message translates to:
  /// **'Step 2'**
  String get newTradeStep2;

  /// No description provided for @newTradeStep3.
  ///
  /// In en, this message translates to:
  /// **'Step 3'**
  String get newTradeStep3;

  /// No description provided for @newTradeStep4.
  ///
  /// In en, this message translates to:
  /// **'Step 4'**
  String get newTradeStep4;

  /// No description provided for @newTradeSectionCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get newTradeSectionCategory;

  /// No description provided for @newTradeSectionQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get newTradeSectionQuantity;

  /// No description provided for @newTradeSectionPricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get newTradeSectionPricing;

  /// No description provided for @newTradeSectionReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get newTradeSectionReview;

  /// No description provided for @newTradeMainCategory.
  ///
  /// In en, this message translates to:
  /// **'Main category'**
  String get newTradeMainCategory;

  /// No description provided for @newTradeCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get newTradeCategory;

  /// No description provided for @newTradeSubCategory.
  ///
  /// In en, this message translates to:
  /// **'Sub-category'**
  String get newTradeSubCategory;

  /// No description provided for @newTradeType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get newTradeType;

  /// No description provided for @newTradeOrigin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get newTradeOrigin;

  /// No description provided for @newTradeCropYear.
  ///
  /// In en, this message translates to:
  /// **'Crop year'**
  String get newTradeCropYear;

  /// No description provided for @newTradeQuantityKg.
  ///
  /// In en, this message translates to:
  /// **'Quantity (kg)'**
  String get newTradeQuantityKg;

  /// No description provided for @newTradePackaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging'**
  String get newTradePackaging;

  /// No description provided for @newTradeMinOrder.
  ///
  /// In en, this message translates to:
  /// **'Min order'**
  String get newTradeMinOrder;

  /// No description provided for @newTradeAvailableDate.
  ///
  /// In en, this message translates to:
  /// **'Available date'**
  String get newTradeAvailableDate;

  /// No description provided for @newTradePricePerKg.
  ///
  /// In en, this message translates to:
  /// **'Price per kg'**
  String get newTradePricePerKg;

  /// No description provided for @newTradeCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get newTradeCurrency;

  /// No description provided for @newTradePaymentTerms.
  ///
  /// In en, this message translates to:
  /// **'Payment terms'**
  String get newTradePaymentTerms;

  /// No description provided for @newTradeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get newTradeDelivery;

  /// No description provided for @newTradeReviewHint.
  ///
  /// In en, this message translates to:
  /// **'Review your trade and publish to the marketplace.'**
  String get newTradeReviewHint;

  /// No description provided for @newTradeReviewType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get newTradeReviewType;

  /// No description provided for @newTradeReviewCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get newTradeReviewCategory;

  /// No description provided for @newTradeReviewOrigin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get newTradeReviewOrigin;

  /// No description provided for @newTradeReviewQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get newTradeReviewQuantity;

  /// No description provided for @newTradeReviewPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get newTradeReviewPrice;

  /// No description provided for @newTradeReviewTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get newTradeReviewTotal;

  /// No description provided for @newTradeMarketplaceLabel.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get newTradeMarketplaceLabel;

  /// No description provided for @newTradeInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid positive number'**
  String get newTradeInvalidNumber;

  /// No description provided for @drawerItemUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get drawerItemUsers;

  /// No description provided for @usersScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'People and businesses on the mandi — grouped by how they use the app.'**
  String get usersScreenSubtitle;

  /// No description provided for @usersTypeVerifiedStores.
  ///
  /// In en, this message translates to:
  /// **'Verified stores (sellers)'**
  String get usersTypeVerifiedStores;

  /// No description provided for @usersTypeBuyersTraders.
  ///
  /// In en, this message translates to:
  /// **'Buyers & traders'**
  String get usersTypeBuyersTraders;

  /// No description provided for @usersTypeGuests.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get usersTypeGuests;

  /// No description provided for @usersTypeBrokers.
  ///
  /// In en, this message translates to:
  /// **'Brokers & agents'**
  String get usersTypeBrokers;

  /// No description provided for @usersTypeAdmins.
  ///
  /// In en, this message translates to:
  /// **'Platform & support'**
  String get usersTypeAdmins;

  /// No description provided for @usersVerifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get usersVerifiedBadge;

  /// No description provided for @drawerItemQuotations.
  ///
  /// In en, this message translates to:
  /// **'Quotations'**
  String get drawerItemQuotations;

  /// No description provided for @quotationsScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Formal price offers between parties — filter by status (demo data).'**
  String get quotationsScreenSubtitle;

  /// No description provided for @quotationIdPrefix.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get quotationIdPrefix;

  /// No description provided for @quotationIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get quotationIssued;

  /// No description provided for @quotationValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get quotationValidUntil;

  /// No description provided for @quotationFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get quotationFrom;

  /// No description provided for @quotationTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get quotationTo;

  /// No description provided for @quotationStatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get quotationStatusDraft;

  /// No description provided for @quotationStatusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get quotationStatusSent;

  /// No description provided for @quotationStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get quotationStatusAccepted;

  /// No description provided for @quotationStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get quotationStatusRejected;

  /// No description provided for @quotationStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get quotationStatusExpired;

  /// No description provided for @quotationsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get quotationsFilterAll;

  /// No description provided for @quotationsEmptyFilter.
  ///
  /// In en, this message translates to:
  /// **'No quotations in this filter.'**
  String get quotationsEmptyFilter;

  /// No description provided for @drawerItemBargaining.
  ///
  /// In en, this message translates to:
  /// **'Bargaining'**
  String get drawerItemBargaining;

  /// No description provided for @drawerItemLedgers.
  ///
  /// In en, this message translates to:
  /// **'Ledgers'**
  String get drawerItemLedgers;

  /// No description provided for @drawerItemCheques.
  ///
  /// In en, this message translates to:
  /// **'Cheques'**
  String get drawerItemCheques;

  /// No description provided for @drawerItemFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get drawerItemFavorites;

  /// No description provided for @modulePlaceholderBody.
  ///
  /// In en, this message translates to:
  /// **'This module will be available in a future update.'**
  String get modulePlaceholderBody;

  /// No description provided for @bargainingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track price back-and-forth with counterparties. Open a thread to reply, counter, accept, or decline (demo session).'**
  String get bargainingSubtitle;

  /// No description provided for @bargainingFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get bargainingFilterAll;

  /// No description provided for @bargainingFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get bargainingFilterActive;

  /// No description provided for @bargainingFilterAgreed.
  ///
  /// In en, this message translates to:
  /// **'Agreed'**
  String get bargainingFilterAgreed;

  /// No description provided for @bargainingFilterDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get bargainingFilterDeclined;

  /// No description provided for @bargainingEmptyFilter.
  ///
  /// In en, this message translates to:
  /// **'No negotiations in this filter.'**
  String get bargainingEmptyFilter;

  /// No description provided for @bargainingWith.
  ///
  /// In en, this message translates to:
  /// **'With'**
  String get bargainingWith;

  /// No description provided for @bargainingRoleBuying.
  ///
  /// In en, this message translates to:
  /// **'You are buying'**
  String get bargainingRoleBuying;

  /// No description provided for @bargainingRoleSelling.
  ///
  /// In en, this message translates to:
  /// **'You are selling'**
  String get bargainingRoleSelling;

  /// No description provided for @bargainingStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get bargainingStatusActive;

  /// No description provided for @bargainingStatusAgreed.
  ///
  /// In en, this message translates to:
  /// **'Agreed'**
  String get bargainingStatusAgreed;

  /// No description provided for @bargainingStatusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get bargainingStatusDeclined;

  /// No description provided for @bargainingTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get bargainingTimelineTitle;

  /// No description provided for @bargainingActorYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get bargainingActorYou;

  /// No description provided for @bargainingEventOpening.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get bargainingEventOpening;

  /// No description provided for @bargainingEventCounterBuyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer counter'**
  String get bargainingEventCounterBuyer;

  /// No description provided for @bargainingEventCounterSeller.
  ///
  /// In en, this message translates to:
  /// **'Seller counter'**
  String get bargainingEventCounterSeller;

  /// No description provided for @bargainingEventAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get bargainingEventAccepted;

  /// No description provided for @bargainingEventDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get bargainingEventDeclined;

  /// No description provided for @bargainingEventSystem.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get bargainingEventSystem;

  /// No description provided for @bargainingActionCounter.
  ///
  /// In en, this message translates to:
  /// **'Counter-offer'**
  String get bargainingActionCounter;

  /// No description provided for @bargainingActionAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get bargainingActionAccept;

  /// No description provided for @bargainingActionDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get bargainingActionDecline;

  /// No description provided for @bargainingCounterTitle.
  ///
  /// In en, this message translates to:
  /// **'Your counter-offer'**
  String get bargainingCounterTitle;

  /// No description provided for @bargainingCounterAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Price / terms'**
  String get bargainingCounterAmountLabel;

  /// No description provided for @bargainingCounterAmountHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Rs 750 / kg'**
  String get bargainingCounterAmountHint;

  /// No description provided for @bargainingCounterNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get bargainingCounterNoteLabel;

  /// No description provided for @bargainingCounterNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Explain your position…'**
  String get bargainingCounterNoteHint;

  /// No description provided for @bargainingCounterCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get bargainingCounterCancel;

  /// No description provided for @bargainingCounterSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send counter'**
  String get bargainingCounterSubmit;

  /// No description provided for @bargainingCounterDefaultNote.
  ///
  /// In en, this message translates to:
  /// **'Updated offer.'**
  String get bargainingCounterDefaultNote;

  /// No description provided for @bargainingSnackCounterPosted.
  ///
  /// In en, this message translates to:
  /// **'Counter-offer sent'**
  String get bargainingSnackCounterPosted;

  /// No description provided for @bargainingSnackAccepted.
  ///
  /// In en, this message translates to:
  /// **'You accepted — move to deal when ready'**
  String get bargainingSnackAccepted;

  /// No description provided for @bargainingSnackDeclined.
  ///
  /// In en, this message translates to:
  /// **'Negotiation closed'**
  String get bargainingSnackDeclined;

  /// No description provided for @ledgerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Running balances with buyers and sellers — filter, search, open a party statement, and record movements (demo session).'**
  String get ledgerSubtitle;

  /// No description provided for @ledgerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search party name…'**
  String get ledgerSearchHint;

  /// No description provided for @ledgerFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get ledgerFilterAll;

  /// No description provided for @ledgerFilterReceivable.
  ///
  /// In en, this message translates to:
  /// **'They owe'**
  String get ledgerFilterReceivable;

  /// No description provided for @ledgerFilterPayable.
  ///
  /// In en, this message translates to:
  /// **'You owe'**
  String get ledgerFilterPayable;

  /// No description provided for @ledgerFilterSettled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get ledgerFilterSettled;

  /// No description provided for @ledgerEmptyList.
  ///
  /// In en, this message translates to:
  /// **'No ledgers match this filter or search.'**
  String get ledgerEmptyList;

  /// No description provided for @ledgerCardBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Net position'**
  String get ledgerCardBalanceLabel;

  /// No description provided for @ledgerBalanceTheyOwe.
  ///
  /// In en, this message translates to:
  /// **'They owe {amount}'**
  String ledgerBalanceTheyOwe(String amount);

  /// No description provided for @ledgerBalanceYouOwe.
  ///
  /// In en, this message translates to:
  /// **'You owe {amount}'**
  String ledgerBalanceYouOwe(String amount);

  /// No description provided for @ledgerBalanceSettledShort.
  ///
  /// In en, this message translates to:
  /// **'Settled (even)'**
  String get ledgerBalanceSettledShort;

  /// No description provided for @ledgerSideSettled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get ledgerSideSettled;

  /// No description provided for @ledgerSideReceivable.
  ///
  /// In en, this message translates to:
  /// **'Receivable'**
  String get ledgerSideReceivable;

  /// No description provided for @ledgerSidePayable.
  ///
  /// In en, this message translates to:
  /// **'Payable'**
  String get ledgerSidePayable;

  /// No description provided for @ledgerDetailCurrentTitle.
  ///
  /// In en, this message translates to:
  /// **'Current net balance'**
  String get ledgerDetailCurrentTitle;

  /// No description provided for @ledgerDetailOpeningLine.
  ///
  /// In en, this message translates to:
  /// **'Opening balance carried in: {amount}'**
  String ledgerDetailOpeningLine(String amount);

  /// No description provided for @ledgerDetailStatementTitle.
  ///
  /// In en, this message translates to:
  /// **'Statement (newest first)'**
  String get ledgerDetailStatementTitle;

  /// No description provided for @ledgerKindOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get ledgerKindOpening;

  /// No description provided for @ledgerKindSaleOnCredit.
  ///
  /// In en, this message translates to:
  /// **'Sale on credit'**
  String get ledgerKindSaleOnCredit;

  /// No description provided for @ledgerKindPurchaseOnCredit.
  ///
  /// In en, this message translates to:
  /// **'Purchase on credit'**
  String get ledgerKindPurchaseOnCredit;

  /// No description provided for @ledgerKindPaymentReceived.
  ///
  /// In en, this message translates to:
  /// **'Payment received'**
  String get ledgerKindPaymentReceived;

  /// No description provided for @ledgerKindPaymentSent.
  ///
  /// In en, this message translates to:
  /// **'Payment sent'**
  String get ledgerKindPaymentSent;

  /// No description provided for @ledgerKindCreditNote.
  ///
  /// In en, this message translates to:
  /// **'Credit note'**
  String get ledgerKindCreditNote;

  /// No description provided for @ledgerKindDebitNote.
  ///
  /// In en, this message translates to:
  /// **'Debit note'**
  String get ledgerKindDebitNote;

  /// No description provided for @ledgerEntryDeltaLabel.
  ///
  /// In en, this message translates to:
  /// **'Change: {value}'**
  String ledgerEntryDeltaLabel(String value);

  /// No description provided for @ledgerEntryBalanceAfter.
  ///
  /// In en, this message translates to:
  /// **'After: {value}'**
  String ledgerEntryBalanceAfter(String value);

  /// No description provided for @ledgerActionRecordMovement.
  ///
  /// In en, this message translates to:
  /// **'Record movement'**
  String get ledgerActionRecordMovement;

  /// No description provided for @ledgerRecordSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Record a movement'**
  String get ledgerRecordSheetTitle;

  /// No description provided for @ledgerFormKindLabel.
  ///
  /// In en, this message translates to:
  /// **'Movement type'**
  String get ledgerFormKindLabel;

  /// No description provided for @ledgerFormAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount (PKR)'**
  String get ledgerFormAmountLabel;

  /// No description provided for @ledgerFormAmountHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 50000'**
  String get ledgerFormAmountHint;

  /// No description provided for @ledgerFormAmountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid positive amount'**
  String get ledgerFormAmountInvalid;

  /// No description provided for @ledgerFormNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Reference (optional)'**
  String get ledgerFormNoteLabel;

  /// No description provided for @ledgerFormNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Invoice #, cheque #, lot id…'**
  String get ledgerFormNoteHint;

  /// No description provided for @ledgerFormCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get ledgerFormCancel;

  /// No description provided for @ledgerFormSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get ledgerFormSave;

  /// No description provided for @ledgerSnackRecorded.
  ///
  /// In en, this message translates to:
  /// **'Movement saved to this ledger'**
  String get ledgerSnackRecorded;

  /// No description provided for @ledgerDropdownSaleOnCredit.
  ///
  /// In en, this message translates to:
  /// **'Sale on credit (they owe more)'**
  String get ledgerDropdownSaleOnCredit;

  /// No description provided for @ledgerDropdownPurchaseOnCredit.
  ///
  /// In en, this message translates to:
  /// **'Purchase on credit (you owe more)'**
  String get ledgerDropdownPurchaseOnCredit;

  /// No description provided for @ledgerDropdownPaymentReceived.
  ///
  /// In en, this message translates to:
  /// **'Payment received from them'**
  String get ledgerDropdownPaymentReceived;

  /// No description provided for @ledgerDropdownPaymentSent.
  ///
  /// In en, this message translates to:
  /// **'Payment you sent to them'**
  String get ledgerDropdownPaymentSent;

  /// No description provided for @ledgerDropdownCreditNote.
  ///
  /// In en, this message translates to:
  /// **'Credit note (in your favour)'**
  String get ledgerDropdownCreditNote;

  /// No description provided for @ledgerDropdownDebitNote.
  ///
  /// In en, this message translates to:
  /// **'Debit note (against you)'**
  String get ledgerDropdownDebitNote;

  /// No description provided for @ledgerMoveTitleSaleOnCredit.
  ///
  /// In en, this message translates to:
  /// **'Sale on credit'**
  String get ledgerMoveTitleSaleOnCredit;

  /// No description provided for @ledgerMoveTitlePurchaseOnCredit.
  ///
  /// In en, this message translates to:
  /// **'Purchase on credit'**
  String get ledgerMoveTitlePurchaseOnCredit;

  /// No description provided for @ledgerMoveTitlePaymentReceived.
  ///
  /// In en, this message translates to:
  /// **'Payment received'**
  String get ledgerMoveTitlePaymentReceived;

  /// No description provided for @ledgerMoveTitlePaymentSent.
  ///
  /// In en, this message translates to:
  /// **'Payment sent'**
  String get ledgerMoveTitlePaymentSent;

  /// No description provided for @ledgerMoveTitleCreditNote.
  ///
  /// In en, this message translates to:
  /// **'Credit note'**
  String get ledgerMoveTitleCreditNote;

  /// No description provided for @ledgerMoveTitleDebitNote.
  ///
  /// In en, this message translates to:
  /// **'Debit note'**
  String get ledgerMoveTitleDebitNote;

  /// No description provided for @favoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Offers, traders, and trades you marked with the heart — filter, search, open a card, or remove (demo session; not synced to a server yet).'**
  String get favoritesSubtitle;

  /// No description provided for @favoritesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search title, trader, or price…'**
  String get favoritesSearchHint;

  /// No description provided for @favoritesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get favoritesFilterAll;

  /// No description provided for @favoritesFilterOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get favoritesFilterOffers;

  /// No description provided for @favoritesFilterTraders.
  ///
  /// In en, this message translates to:
  /// **'Traders'**
  String get favoritesFilterTraders;

  /// No description provided for @favoritesFilterTrades.
  ///
  /// In en, this message translates to:
  /// **'Trades'**
  String get favoritesFilterTrades;

  /// No description provided for @favoritesEmptyAll.
  ///
  /// In en, this message translates to:
  /// **'Nothing saved yet. Heart items from the mandi to see them here.'**
  String get favoritesEmptyAll;

  /// No description provided for @favoritesEmptyFilter.
  ///
  /// In en, this message translates to:
  /// **'No favorites match this filter or search.'**
  String get favoritesEmptyFilter;

  /// No description provided for @favoritesKindOffer.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get favoritesKindOffer;

  /// No description provided for @favoritesKindTrader.
  ///
  /// In en, this message translates to:
  /// **'Trader'**
  String get favoritesKindTrader;

  /// No description provided for @favoritesKindTrade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get favoritesKindTrade;

  /// No description provided for @favoritesSavedOn.
  ///
  /// In en, this message translates to:
  /// **'Saved {date}'**
  String favoritesSavedOn(String date);

  /// No description provided for @favoritesRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove favorite?'**
  String get favoritesRemoveTitle;

  /// No description provided for @favoritesRemoveBody.
  ///
  /// In en, this message translates to:
  /// **'Remove “{title}” from your saved list?'**
  String favoritesRemoveBody(String title);

  /// No description provided for @favoritesRemoveCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get favoritesRemoveCancel;

  /// No description provided for @favoritesRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get favoritesRemoveConfirm;

  /// No description provided for @favoritesSnackRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get favoritesSnackRemoved;

  /// No description provided for @favoritesDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved item'**
  String get favoritesDetailTitle;

  /// No description provided for @favoritesRemoveFromList.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get favoritesRemoveFromList;

  /// No description provided for @chequesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track cheques you received or issued — filters, search, lifecycle actions, timeline, and register new instruments (demo session).'**
  String get chequesSubtitle;

  /// No description provided for @chequesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search party, bank, or cheque #…'**
  String get chequesSearchHint;

  /// No description provided for @chequesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get chequesFilterAll;

  /// No description provided for @chequesFilterOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get chequesFilterOutstanding;

  /// No description provided for @chequesFilterClearing.
  ///
  /// In en, this message translates to:
  /// **'In clearing'**
  String get chequesFilterClearing;

  /// No description provided for @chequesFilterCleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get chequesFilterCleared;

  /// No description provided for @chequesFilterBouncedOrCancelled.
  ///
  /// In en, this message translates to:
  /// **'Bounced / void'**
  String get chequesFilterBouncedOrCancelled;

  /// No description provided for @chequesEmptyList.
  ///
  /// In en, this message translates to:
  /// **'No cheques match this filter or search.'**
  String get chequesEmptyList;

  /// No description provided for @chequesDirectionReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get chequesDirectionReceived;

  /// No description provided for @chequesDirectionIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get chequesDirectionIssued;

  /// No description provided for @chequesStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get chequesStatusPending;

  /// No description provided for @chequesStatusClearing.
  ///
  /// In en, this message translates to:
  /// **'In clearing'**
  String get chequesStatusClearing;

  /// No description provided for @chequesStatusCleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get chequesStatusCleared;

  /// No description provided for @chequesStatusBounced.
  ///
  /// In en, this message translates to:
  /// **'Bounced'**
  String get chequesStatusBounced;

  /// No description provided for @chequesStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Void'**
  String get chequesStatusCancelled;

  /// No description provided for @chequesCardChequeNumber.
  ///
  /// In en, this message translates to:
  /// **'Cheque #'**
  String get chequesCardChequeNumber;

  /// No description provided for @chequesCardMatures.
  ///
  /// In en, this message translates to:
  /// **'Matures {date}'**
  String chequesCardMatures(String date);

  /// No description provided for @chequesDetailDates.
  ///
  /// In en, this message translates to:
  /// **'Issued {issue} · Matures {maturity}'**
  String chequesDetailDates(String issue, String maturity);

  /// No description provided for @chequesTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Timeline (newest first)'**
  String get chequesTimelineTitle;

  /// No description provided for @chequesEventKindRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get chequesEventKindRegistered;

  /// No description provided for @chequesEventKindSentToBank.
  ///
  /// In en, this message translates to:
  /// **'With bank'**
  String get chequesEventKindSentToBank;

  /// No description provided for @chequesEventKindCleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get chequesEventKindCleared;

  /// No description provided for @chequesEventKindBounced.
  ///
  /// In en, this message translates to:
  /// **'Bounced'**
  String get chequesEventKindBounced;

  /// No description provided for @chequesEventKindCancelled.
  ///
  /// In en, this message translates to:
  /// **'Voided'**
  String get chequesEventKindCancelled;

  /// No description provided for @chequesEventKindNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get chequesEventKindNote;

  /// No description provided for @chequesActionSendToBank.
  ///
  /// In en, this message translates to:
  /// **'Send to bank / presented'**
  String get chequesActionSendToBank;

  /// No description provided for @chequesActionMarkCleared.
  ///
  /// In en, this message translates to:
  /// **'Mark cleared'**
  String get chequesActionMarkCleared;

  /// No description provided for @chequesActionMarkBounced.
  ///
  /// In en, this message translates to:
  /// **'Mark bounced'**
  String get chequesActionMarkBounced;

  /// No description provided for @chequesActionCancelCheque.
  ///
  /// In en, this message translates to:
  /// **'Void cheque'**
  String get chequesActionCancelCheque;

  /// No description provided for @chequesActionAddNote.
  ///
  /// In en, this message translates to:
  /// **'Add note'**
  String get chequesActionAddNote;

  /// No description provided for @chequesEventDepositTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposited with your bank for clearing.'**
  String get chequesEventDepositTitle;

  /// No description provided for @chequesEventPresentedTitle.
  ///
  /// In en, this message translates to:
  /// **'Payee presented — under clearing.'**
  String get chequesEventPresentedTitle;

  /// No description provided for @chequesEventClearedTitle.
  ///
  /// In en, this message translates to:
  /// **'Marked cleared (demo).'**
  String get chequesEventClearedTitle;

  /// No description provided for @chequesEventBouncedTitle.
  ///
  /// In en, this message translates to:
  /// **'Marked bounced / dishonoured (demo).'**
  String get chequesEventBouncedTitle;

  /// No description provided for @chequesEventCancelledTitle.
  ///
  /// In en, this message translates to:
  /// **'Cheque voided (demo).'**
  String get chequesEventCancelledTitle;

  /// No description provided for @chequesEventNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Note added'**
  String get chequesEventNoteTitle;

  /// No description provided for @chequesSnackSentToBank.
  ///
  /// In en, this message translates to:
  /// **'Status updated — in clearing'**
  String get chequesSnackSentToBank;

  /// No description provided for @chequesSnackCleared.
  ///
  /// In en, this message translates to:
  /// **'Marked cleared'**
  String get chequesSnackCleared;

  /// No description provided for @chequesSnackBounced.
  ///
  /// In en, this message translates to:
  /// **'Marked bounced'**
  String get chequesSnackBounced;

  /// No description provided for @chequesSnackCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cheque voided'**
  String get chequesSnackCancelled;

  /// No description provided for @chequesSnackNoteAdded.
  ///
  /// In en, this message translates to:
  /// **'Note saved on this cheque'**
  String get chequesSnackNoteAdded;

  /// No description provided for @chequesSnackRegistered.
  ///
  /// In en, this message translates to:
  /// **'Cheque registered'**
  String get chequesSnackRegistered;

  /// No description provided for @chequesDialogBounceTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as bounced?'**
  String get chequesDialogBounceTitle;

  /// No description provided for @chequesDialogBounceBody.
  ///
  /// In en, this message translates to:
  /// **'This records a dishonoured cheque for this demo session.'**
  String get chequesDialogBounceBody;

  /// No description provided for @chequesDialogCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Void this cheque?'**
  String get chequesDialogCancelTitle;

  /// No description provided for @chequesDialogCancelBody.
  ///
  /// In en, this message translates to:
  /// **'Use when the instrument is cancelled before clearing. Demo only.'**
  String get chequesDialogCancelBody;

  /// No description provided for @chequesDialogNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get chequesDialogNo;

  /// No description provided for @chequesDialogYesBounce.
  ///
  /// In en, this message translates to:
  /// **'Mark bounced'**
  String get chequesDialogYesBounce;

  /// No description provided for @chequesDialogYesCancel.
  ///
  /// In en, this message translates to:
  /// **'Void cheque'**
  String get chequesDialogYesCancel;

  /// No description provided for @chequesRegisterFab.
  ///
  /// In en, this message translates to:
  /// **'Register cheque'**
  String get chequesRegisterFab;

  /// No description provided for @chequesRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Register a cheque'**
  String get chequesRegisterTitle;

  /// No description provided for @chequesRegisterDirection.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get chequesRegisterDirection;

  /// No description provided for @chequesRegisterParty.
  ///
  /// In en, this message translates to:
  /// **'Party name'**
  String get chequesRegisterParty;

  /// No description provided for @chequesRegisterBank.
  ///
  /// In en, this message translates to:
  /// **'Bank & branch'**
  String get chequesRegisterBank;

  /// No description provided for @chequesRegisterNumber.
  ///
  /// In en, this message translates to:
  /// **'Cheque number'**
  String get chequesRegisterNumber;

  /// No description provided for @chequesRegisterAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount (PKR)'**
  String get chequesRegisterAmount;

  /// No description provided for @chequesRegisterAmountHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 125000'**
  String get chequesRegisterAmountHint;

  /// No description provided for @chequesRegisterAmountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid positive amount'**
  String get chequesRegisterAmountInvalid;

  /// No description provided for @chequesRegisterIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue date'**
  String get chequesRegisterIssueDate;

  /// No description provided for @chequesRegisterMaturityDate.
  ///
  /// In en, this message translates to:
  /// **'Maturity / value date'**
  String get chequesRegisterMaturityDate;

  /// No description provided for @chequesRegisterDateHint.
  ///
  /// In en, this message translates to:
  /// **'YYYY-MM-DD'**
  String get chequesRegisterDateHint;

  /// No description provided for @chequesRegisterNote.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get chequesRegisterNote;

  /// No description provided for @chequesRegisterSubmit.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get chequesRegisterSubmit;

  /// No description provided for @chequesRegisterCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get chequesRegisterCancel;

  /// No description provided for @chequesRegisterEventLogged.
  ///
  /// In en, this message translates to:
  /// **'Cheque registered in Mandi Online.'**
  String get chequesRegisterEventLogged;

  /// No description provided for @chequesNoteSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get chequesNoteSheetTitle;

  /// No description provided for @chequesNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Reference, follow-up, bank officer…'**
  String get chequesNoteHint;

  /// No description provided for @chequesNoteSave.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get chequesNoteSave;

  /// No description provided for @tradeDetailBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get tradeDetailBack;

  /// No description provided for @tradeDetailPerKg.
  ///
  /// In en, this message translates to:
  /// **'per kg'**
  String get tradeDetailPerKg;

  /// No description provided for @tradeDetailPriceTotalHint.
  ///
  /// In en, this message translates to:
  /// **'listed total'**
  String get tradeDetailPriceTotalHint;

  /// No description provided for @tradeDetailCategoryDryFruits.
  ///
  /// In en, this message translates to:
  /// **'Dry Fruits'**
  String get tradeDetailCategoryDryFruits;

  /// No description provided for @tradeDetailCategorySpices.
  ///
  /// In en, this message translates to:
  /// **'Spices'**
  String get tradeDetailCategorySpices;

  /// No description provided for @tradeDetailCategoryNuts.
  ///
  /// In en, this message translates to:
  /// **'Nuts'**
  String get tradeDetailCategoryNuts;

  /// No description provided for @tradeDetailCategoryHerbs.
  ///
  /// In en, this message translates to:
  /// **'Herbs'**
  String get tradeDetailCategoryHerbs;

  /// No description provided for @tradeDetailRatingReviews.
  ///
  /// In en, this message translates to:
  /// **'★ {rating} · {count} reviews'**
  String tradeDetailRatingReviews(String rating, String count);

  /// No description provided for @tradeDetailSoldByPrefix.
  ///
  /// In en, this message translates to:
  /// **'Sold by: '**
  String get tradeDetailSoldByPrefix;

  /// No description provided for @tradeDetailSpecOrigin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get tradeDetailSpecOrigin;

  /// No description provided for @tradeDetailSpecCropYear.
  ///
  /// In en, this message translates to:
  /// **'Crop year'**
  String get tradeDetailSpecCropYear;

  /// No description provided for @tradeDetailSpecAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get tradeDetailSpecAvailable;

  /// No description provided for @tradeDetailBuyCash.
  ///
  /// In en, this message translates to:
  /// **'Buy Cash'**
  String get tradeDetailBuyCash;

  /// No description provided for @tradeDetailBuyCredit.
  ///
  /// In en, this message translates to:
  /// **'Buy Credit'**
  String get tradeDetailBuyCredit;

  /// No description provided for @tradeDetailOfferCash.
  ///
  /// In en, this message translates to:
  /// **'Offer (cash)'**
  String get tradeDetailOfferCash;

  /// No description provided for @tradeDetailOfferCredit.
  ///
  /// In en, this message translates to:
  /// **'Offer (credit)'**
  String get tradeDetailOfferCredit;

  /// No description provided for @tradeDetailSendQuotation.
  ///
  /// In en, this message translates to:
  /// **'Send quotation'**
  String get tradeDetailSendQuotation;

  /// No description provided for @tradeDetailStartBargaining.
  ///
  /// In en, this message translates to:
  /// **'Start bargaining'**
  String get tradeDetailStartBargaining;

  /// No description provided for @tradeDetailTrustShipping.
  ///
  /// In en, this message translates to:
  /// **'Free shipping'**
  String get tradeDetailTrustShipping;

  /// No description provided for @tradeDetailTrustQuality.
  ///
  /// In en, this message translates to:
  /// **'Quality assured'**
  String get tradeDetailTrustQuality;

  /// No description provided for @tradeDetailTrustChat.
  ///
  /// In en, this message translates to:
  /// **'Direct chat'**
  String get tradeDetailTrustChat;

  /// No description provided for @tradeDetailDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get tradeDetailDetailsTitle;

  /// No description provided for @tradeDetailFavoriteOn.
  ///
  /// In en, this message translates to:
  /// **'Saved to favorites (demo)'**
  String get tradeDetailFavoriteOn;

  /// No description provided for @tradeDetailFavoriteOff.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites (demo)'**
  String get tradeDetailFavoriteOff;

  /// No description provided for @tradeDetailActionDemo.
  ///
  /// In en, this message translates to:
  /// **'Action — demo only'**
  String get tradeDetailActionDemo;

  /// No description provided for @tradeDetailDescriptionBody.
  ///
  /// In en, this message translates to:
  /// **'{product} from {trader}. Quantity {qty} at {price}. Crop year {year}. Graded for wholesale on Mandi Online (demo listing).'**
  String tradeDetailDescriptionBody(
    String product,
    String trader,
    String qty,
    String price,
    String year,
  );
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
