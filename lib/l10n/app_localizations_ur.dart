// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'مندی آن لائن';

  @override
  String get splashLoading => 'لوڈ ہو رہا ہے…';

  @override
  String get homeTitle => 'ہوم';

  @override
  String get loginTitle => 'سائن ان';

  @override
  String get onboardingTitle => 'خوش آمدید';

  @override
  String get tradesTitle => 'لین دین';

  @override
  String get dealsTitle => 'معاہدے';

  @override
  String get messagesTitle => 'پیغامات';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get signOut => 'سائن آؤٹ';

  @override
  String get loginErrorInvalidCredentials =>
      'ای میل یا پاس ورڈ ڈیمو اکاؤنٹ سے میل نہیں کھاتا۔ اوپر والے درست الفاظ استعمال کریں، یا مہمان کے طور پر داخل ہوں۔';

  @override
  String get loginSubtitle => 'اپنے ٹریڈنگ فلور پر واپس خوش آمدید';

  @override
  String loginDemoCredentials(String email, String password) {
    return 'ڈیمو: $email · $password';
  }

  @override
  String get emailOrPhoneLabel => 'ای میل یا فون';

  @override
  String get passwordLabel => 'پاس ورڈ';

  @override
  String get forgotPassword => 'پاس ورڈ بھول گئے؟';

  @override
  String get forgotPasswordComingSoon => 'پاس ورڈ بازیافت — جلد آ رہی ہے';

  @override
  String get signInCta => 'سائن ان';

  @override
  String get loginAsGuest => 'مہمان کے طور پر لاگ ان';

  @override
  String get languageSwitchToUrdu => 'اردو';

  @override
  String get languageSwitchToEnglish => 'English';

  @override
  String get showPassword => 'پاس ورڈ دکھائیں';

  @override
  String get hidePassword => 'پاس ورڈ چھپائیں';

  @override
  String get navHome => 'ہوم';

  @override
  String get navTrades => 'لین دین';

  @override
  String get navDeals => 'معاہدے';

  @override
  String get navMessages => 'پیغامات';

  @override
  String get drawerGuest => 'مہمان';

  @override
  String get drawerMemberDefault => 'مندی ممبر';

  @override
  String get drawerUserDefault => 'صارف';

  @override
  String get drawerBrowsingGuest => 'مہمان موڈ میں براؤز کر رہے ہیں';

  @override
  String get drawerSignedIn => 'سائن ان';

  @override
  String get drawerProfile => 'پروفائل';

  @override
  String get drawerSettings => 'ترتیبات';

  @override
  String get drawerOrderHistory => 'آرڈر کی تاریخ';

  @override
  String get drawerHelp => 'مدد و سپورٹ';

  @override
  String get drawerLogout => 'لاگ آؤٹ';

  @override
  String get comingSoonProfile => 'پروفائل — جلد دستیاب';

  @override
  String get comingSoonSettings => 'ترتیبات — جلد دستیاب';

  @override
  String get comingSoonHistory => 'تاریخ — جلد دستیاب';

  @override
  String get comingSoonSupport => 'سپورٹ — جلد دستیاب';

  @override
  String get comingSoonCreateTrade => 'نیا لین دین — جلد دستیاب';

  @override
  String get greetingMorning => 'صبح بخیر 👋';

  @override
  String get guestHomeSubtitle => 'زمرے اور لائیو آفرز دیکھیں';

  @override
  String get demoStoreSubtitle => 'پنجابی اسٹور · لاہور';

  @override
  String get demoProfileName => 'اظہر اقبال اعوان';

  @override
  String get searchHintHome => 'مصالحہ، خشک میوہ جات تلاش کریں…';

  @override
  String get dashboardStatTrades => 'لین دین';

  @override
  String get dashboardStatDeals => 'معاہدے';

  @override
  String get dashboardStatLedgers => 'کھاتے';

  @override
  String get dashboardStatActiveOffers => 'فعال آفرز';

  @override
  String get sectionTopCategories => 'مقبول زمرے';

  @override
  String get sectionLiveOffers => 'لائیو آفرز';

  @override
  String get sectionRecentTrades => 'حالیہ لین دین';

  @override
  String get viewAll => 'سب دیکھیں';

  @override
  String get categorySpices => 'مصالحہ';

  @override
  String get categoryDryFruits => 'خشک میوہ جات';

  @override
  String get categoryNuts => 'گری دار میوے';

  @override
  String get categoryHerbs => 'جڑی بوٹیاں';

  @override
  String itemsCount(int count) {
    return '$count اشیاء';
  }

  @override
  String get tradeLoadError => 'لین دین لوڈ نہیں ہو سکا';

  @override
  String get noTradesYet => 'کوئی لین دین نہیں';

  @override
  String get offerCategoryPakistan => 'مصالحہ · پاکستان';

  @override
  String get offerCategoryGuatemala => 'مصالحہ · گوئٹے مالا';

  @override
  String get offerCategoryIndia => 'مصالحہ · بھارت';

  @override
  String get productDriedRedChilies => 'خشک لال مرچ';

  @override
  String get productGreenCardamom => 'سبز الائچی';

  @override
  String get productTurmericPowder => 'ہلدی پاؤڈر';

  @override
  String get productBlackPepper => 'کالی مرچ (سابت)';

  @override
  String get productCinnamonSticks => 'دار چینی کی چھڑیاں';

  @override
  String get productClovesWhole => 'لونگ (سابت)';

  @override
  String get priceLabel => 'قیمت';

  @override
  String get unitPerKg => '/کلو';

  @override
  String get tradeBadgeSelling => 'فروخت';

  @override
  String get tradeBadgeBuying => 'خریداری';

  @override
  String get tradesScreenSubtitle => 'خرید و فروخت کے لین دین منظم کریں';

  @override
  String get filterAll => 'سب';

  @override
  String get filterBuying => 'خریداری';

  @override
  String get filterSelling => 'فروخت';

  @override
  String get filterButton => 'فلٹر';

  @override
  String get browseProducts => 'مصنوعات براؤز کریں';

  @override
  String get browseRegionPakistan => 'پاکستان';

  @override
  String get browseRegionGuatemala => 'گوئٹے مالا';

  @override
  String get dealsScreenSubtitle => 'فعال اور مکمل لین دین';

  @override
  String get dealSellingSummary => 'میری فروخت کے معاہدے';

  @override
  String get dealBuyingSummary => 'میری خرید کے معاہدے';

  @override
  String get paymentLabel => 'ادائیگی';

  @override
  String get shippingLabel => 'شپنگ';

  @override
  String get invoiceLabel => 'انوائس';

  @override
  String get statusActive => 'فعال';

  @override
  String get statusPaid => 'ادا شدہ';

  @override
  String get statusUnpaid => 'غیر ادا';

  @override
  String get statusDelivered => 'پہنچا دیا';

  @override
  String get statusPending => 'زیر التواء';

  @override
  String get statusCompleted => 'مکمل';

  @override
  String get downloadInvoice => 'انوائس ڈاؤن لوڈ';

  @override
  String get dealMessagesButton => 'پیغامات';

  @override
  String get raiseDispute => 'تنازع';

  @override
  String get messagesScreenSubtitle =>
      'لین دین اور معاہدوں پر براہ راست پیغامات';

  @override
  String get tabSelling => 'فروخت';

  @override
  String get tabBuying => 'خریداری';

  @override
  String get chatHeaderDeal => 'معاہدہ #m1';

  @override
  String get chatParticipantSample => 'کراچی ہول سیل';

  @override
  String get chatInputHint => 'پیغام لکھیں…';

  @override
  String get genericError => 'خرابی';

  @override
  String get screenProfileTitle => 'پروفائل';

  @override
  String get screenSettingsTitle => 'ترتیبات';

  @override
  String get screenOrderHistoryTitle => 'آرڈر کی تاریخ';

  @override
  String get screenHelpSupportTitle => 'مدد و سپورٹ';

  @override
  String get profileGuestBanner =>
      'آپ مہمان کے طور پر براؤز کر رہے ہیں۔ پروفائل اور آرڈر سنک کرنے کے لیے سائن ان کریں۔';

  @override
  String get profileSectionAccount => 'اکاؤنٹ';

  @override
  String get profileLabelEmail => 'ای میل';

  @override
  String get profileEmailGuestPlaceholder => 'سائن ان کے بعد دستیاب';

  @override
  String get profileLabelPhone => 'فون';

  @override
  String get profileDemoPhone => '+92 300 0000000';

  @override
  String get profileStoreRole => 'تصدیق شدہ اسٹور';

  @override
  String get profileEditProfile => 'پروفائل میں ترمیم';

  @override
  String get profileEditComingSoon =>
      'پروفائل میں ترمیم اگلی اپ ڈیٹ میں دستیاب ہو گی۔';

  @override
  String get settingsNotifications => 'پش اطلاعات';

  @override
  String get settingsNotificationsSubtitle => 'لین دین اور ڈیل کی اطلاعات';

  @override
  String get settingsEmailDigest => 'ہفتہ وار ای میل خلاصہ';

  @override
  String get settingsEmailDigestSubtitle => 'آپ کی مندی سرگرمی کا خلاصہ';

  @override
  String get settingsAppLanguage => 'ایپ کی زبان';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageUrdu => 'اردو';

  @override
  String get orderHistoryPlaced => 'شروع';

  @override
  String get orderHistoryOrder => 'آرڈر';

  @override
  String get orderStatusProcessing => 'زیر کارروائی';

  @override
  String get orderStatusCancelled => 'منسوخ';

  @override
  String get helpContactSection => 'رابطہ';

  @override
  String get helpSupportEmail => 'support@mandionline.pk';

  @override
  String get helpSupportPhone => '+92 800 000 0000';

  @override
  String get helpFaqOrdersTitle => 'آرڈر کیسے ٹریک کریں؟';

  @override
  String get helpFaqOrdersBody =>
      'مینو سے آرڈر کی تاریخ کھولیں۔ ہر قطار میں حیثیت دکھائی دیتی ہے اور ڈیل کھول کر شپنگ کی تفصیلات دیکھیں۔';

  @override
  String get helpFaqPaymentsTitle => 'ادائیگی کب لی جاتی ہے؟';

  @override
  String get helpFaqPaymentsBody =>
      'رقم اسکرو میں رہتی ہے جب تک دونوں فریق ڈیلیوری کی تصدیق نہ کریں۔ یہ ڈیمو ایپ ہے — کوئی حقیقی ادائیگی نہیں ہوتی۔';

  @override
  String get helpFaqDisputesTitle => 'تنازع کیسے درج کریں؟';

  @override
  String get helpFaqDisputesBody =>
      'ڈیل کارڈ سے تنازع استعمال کریں۔ ہماری ٹیم دو کاروباری دنوں میں جائزہ لے گی (صرف ڈیمو)۔';

  @override
  String get listDetailOffersSubtitle => 'اس ڈیمو کیٹلاگ کی تمام فعال فہرستیں';

  @override
  String get helpFaqHeading => 'عمومی سوالات';

  @override
  String get snackCopiedToClipboard => 'کلپ بورڈ پر کاپی ہو گیا';

  @override
  String get notificationsTitle => 'اطلاعات';

  @override
  String get notificationsMarkAllRead => 'سب پڑھا ہوا';

  @override
  String get notificationsEmpty => 'کوئی اطلاع نہیں';

  @override
  String get notifDealUpdateTitle => 'ڈیل اپ ڈیٹ';

  @override
  String get notifDealUpdateBody => 'آپ کی ڈیل #4521 کی حیثیت مکمل ہو گئی۔';

  @override
  String get notifNewMessageTitle => 'نیا پیغام';

  @override
  String get notifNewMessageBody =>
      'کراچی ہول سیل نے لین دین #4587 پر پیغام بھیجا۔';

  @override
  String get notifPaymentTitle => 'ادائیگی موصول';

  @override
  String get notifPaymentBody => 'ڈیل #4500 کے لیے Rs 168,000 جمع ہو گئے۔';

  @override
  String get notifShipmentTitle => 'شپنگ جاری';

  @override
  String get notifShipmentBody => 'کیریئر نے آپ کا آرڈر ORD-24089 اٹھا لیا۔';

  @override
  String get notifReminderTitle => 'ہفتہ وار خلاصہ';

  @override
  String get notifReminderBody =>
      'اس ہفتے آپ کے 3 فعال لین دین اور 2 کھلی ڈیلز ہیں۔';

  @override
  String get createTradeTitle => 'نیا لین دین';

  @override
  String get createTradeSubtitle =>
      'چار مراحل میں خرید یا فروخت کا لین دین بنائیں';

  @override
  String get createTradeSide => 'طرف';

  @override
  String get createTradeBuying => 'خرید';

  @override
  String get createTradeSelling => 'فروخت';

  @override
  String get createTradeProduct => 'مصنوعات';

  @override
  String get createTradeTrader => 'دوسری پارٹی / تاجر';

  @override
  String get createTradeQty => 'مقدار';

  @override
  String get createTradePrice => 'قیمت';

  @override
  String get createTradeSubmit => 'لین دین بنائیں';

  @override
  String get createTradeSuccess => 'لین دین بن گیا';

  @override
  String get createTradeProductHint => 'مثلاً خشک لال مرچ';

  @override
  String get createTradeTraderHint => 'مثلاً کراچی ہول سیل';

  @override
  String get createTradeQtyHint => 'مثلاً 500 کلو';

  @override
  String get createTradePriceHint => 'مثلاً Rs 390,000';

  @override
  String get newTradeBack => 'واپس';

  @override
  String get newTradeNext => 'آگے';

  @override
  String get newTradePublish => 'لین دین شائع کریں';

  @override
  String get newTradeStep1 => 'مرحلہ 1';

  @override
  String get newTradeStep2 => 'مرحلہ 2';

  @override
  String get newTradeStep3 => 'مرحلہ 3';

  @override
  String get newTradeStep4 => 'مرحلہ 4';

  @override
  String get newTradeSectionCategory => 'زمرہ';

  @override
  String get newTradeSectionQuantity => 'مقدار';

  @override
  String get newTradeSectionPricing => 'قیمت';

  @override
  String get newTradeSectionReview => 'جائزہ';

  @override
  String get newTradeMainCategory => 'بنیادی زمرہ';

  @override
  String get newTradeCategory => 'زمرہ';

  @override
  String get newTradeSubCategory => 'ذیلی زمرہ';

  @override
  String get newTradeType => 'قسم';

  @override
  String get newTradeOrigin => 'اصل';

  @override
  String get newTradeCropYear => 'فصل کا سال';

  @override
  String get newTradeQuantityKg => 'مقدار (کلو)';

  @override
  String get newTradePackaging => 'پیکنگ';

  @override
  String get newTradeMinOrder => 'کم از کم آرڈر';

  @override
  String get newTradeAvailableDate => 'دستیابی کی تاریخ';

  @override
  String get newTradePricePerKg => 'فی کلو قیمت';

  @override
  String get newTradeCurrency => 'کرنسی';

  @override
  String get newTradePaymentTerms => 'ادائیگی کی شرائط';

  @override
  String get newTradeDelivery => 'ترسیل';

  @override
  String get newTradeReviewHint => 'جائزہ لیں اور مارکیٹ میں شائع کریں۔';

  @override
  String get newTradeReviewType => 'قسم';

  @override
  String get newTradeReviewCategory => 'زمرہ';

  @override
  String get newTradeReviewOrigin => 'اصل';

  @override
  String get newTradeReviewQuantity => 'مقدار';

  @override
  String get newTradeReviewPrice => 'قیمت';

  @override
  String get newTradeReviewTotal => 'کل';

  @override
  String get newTradeMarketplaceLabel => 'مارکیٹ';

  @override
  String get newTradeInvalidNumber => 'درست مثبت عدد لکھیں';

  @override
  String get drawerItemUsers => 'صارفین';

  @override
  String get usersScreenSubtitle =>
      'مندی پر افراد اور کاروبار — استعمال کے مطابق گروپ۔';

  @override
  String get usersTypeVerifiedStores => 'تصدیق شدہ اسٹور (فروخت کنندہ)';

  @override
  String get usersTypeBuyersTraders => 'خریدار و تاجر';

  @override
  String get usersTypeGuests => 'مہمان';

  @override
  String get usersTypeBrokers => 'دلال و ایجنٹ';

  @override
  String get usersTypeAdmins => 'پلیٹ فارم و سپورٹ';

  @override
  String get usersVerifiedBadge => 'تصدیق شدہ';

  @override
  String get drawerItemQuotations => 'اقتباسات';

  @override
  String get quotationsScreenSubtitle =>
      'فریقین کے درمیان باقاعدہ قیمت کی پیشکشیں — حیثیت سے فلٹر (ڈیمو ڈیٹا)۔';

  @override
  String get quotationIdPrefix => 'اقتباس';

  @override
  String get quotationIssued => 'جاری';

  @override
  String get quotationValidUntil => 'معتبر تک';

  @override
  String get quotationFrom => 'بھیجنے والا';

  @override
  String get quotationTo => 'وصول کنندہ';

  @override
  String get quotationStatusDraft => 'مسودہ';

  @override
  String get quotationStatusSent => 'بھیجا گیا';

  @override
  String get quotationStatusAccepted => 'منظور';

  @override
  String get quotationStatusRejected => 'مسترد';

  @override
  String get quotationStatusExpired => 'ختم مدت';

  @override
  String get quotationsFilterAll => 'سب';

  @override
  String get quotationsEmptyFilter => 'اس فلٹر میں کوئی اقتباس نہیں۔';

  @override
  String get drawerItemBargaining => 'مذاکرات';

  @override
  String get drawerItemLedgers => 'کھاتے';

  @override
  String get drawerItemCheques => 'چیک';

  @override
  String get drawerItemFavorites => 'پسندیدہ';

  @override
  String get modulePlaceholderBody => 'یہ ماڈیول اگلی اپ ڈیٹ میں دستیاب ہو گا۔';

  @override
  String get bargainingSubtitle =>
      'دوسری پارٹی کے ساتھ قیمت کی بات چیت۔ تھریڈ کھول کر جواب، نئی پیشکش، قبول یا مسترد کریں (ڈیمو)۔';

  @override
  String get bargainingFilterAll => 'سب';

  @override
  String get bargainingFilterActive => 'فعال';

  @override
  String get bargainingFilterAgreed => 'متفق';

  @override
  String get bargainingFilterDeclined => 'مسترد';

  @override
  String get bargainingEmptyFilter => 'اس فلٹر میں کوئی مذاکرہ نہیں۔';

  @override
  String get bargainingWith => 'ساتھ';

  @override
  String get bargainingRoleBuying => 'آپ خریدار ہیں';

  @override
  String get bargainingRoleSelling => 'آپ فروخت کنندہ ہیں';

  @override
  String get bargainingStatusActive => 'فعال';

  @override
  String get bargainingStatusAgreed => 'متفق';

  @override
  String get bargainingStatusDeclined => 'مسترد';

  @override
  String get bargainingTimelineTitle => 'وقفے';

  @override
  String get bargainingActorYou => 'آپ';

  @override
  String get bargainingEventOpening => 'پیشکش';

  @override
  String get bargainingEventCounterBuyer => 'خریدار کی پیشکش';

  @override
  String get bargainingEventCounterSeller => 'فروخت کنندہ کی پیشکش';

  @override
  String get bargainingEventAccepted => 'قبول';

  @override
  String get bargainingEventDeclined => 'مسترد';

  @override
  String get bargainingEventSystem => 'اطلاع';

  @override
  String get bargainingActionCounter => 'نئی پیشکش';

  @override
  String get bargainingActionAccept => 'قبول کریں';

  @override
  String get bargainingActionDecline => 'مسترد';

  @override
  String get bargainingCounterTitle => 'آپ کی نئی پیشکش';

  @override
  String get bargainingCounterAmountLabel => 'قیمت / شرائط';

  @override
  String get bargainingCounterAmountHint => 'مثلاً Rs 750 / کلو';

  @override
  String get bargainingCounterNoteLabel => 'نوٹ (اختیاری)';

  @override
  String get bargainingCounterNoteHint => 'اپنی بات لکھیں…';

  @override
  String get bargainingCounterCancel => 'منسوخ';

  @override
  String get bargainingCounterSubmit => 'بھیجیں';

  @override
  String get bargainingCounterDefaultNote => 'اپ ڈیٹ شدہ پیشکش۔';

  @override
  String get bargainingSnackCounterPosted => 'نئی پیشکش بھیج دی گئی';

  @override
  String get bargainingSnackAccepted => 'قبول کر لیا — ڈیل کے لیے تیار ہوں';

  @override
  String get bargainingSnackDeclined => 'مذاکرہ بند';

  @override
  String get ledgerSubtitle =>
      'خریدار و فروخت کنندگان کے ساتھ کھاتے — فلٹر، تلاش، اسٹیٹمنٹ، اور اندراج (ڈیمو)۔';

  @override
  String get ledgerSearchHint => 'نام تلاش کریں…';

  @override
  String get ledgerFilterAll => 'سب';

  @override
  String get ledgerFilterReceivable => 'وہ دیندار';

  @override
  String get ledgerFilterPayable => 'آپ دیندار';

  @override
  String get ledgerFilterSettled => 'برابر';

  @override
  String get ledgerEmptyList => 'اس فلٹر یا تلاش میں کوئی کھاتا نہیں۔';

  @override
  String get ledgerCardBalanceLabel => 'خالص حالت';

  @override
  String ledgerBalanceTheyOwe(String amount) {
    return 'وہ دیں $amount';
  }

  @override
  String ledgerBalanceYouOwe(String amount) {
    return 'آپ دیں $amount';
  }

  @override
  String get ledgerBalanceSettledShort => 'برابر (صفر)';

  @override
  String get ledgerSideSettled => 'برابر';

  @override
  String get ledgerSideReceivable => 'وصولی';

  @override
  String get ledgerSidePayable => 'ادائیگی';

  @override
  String get ledgerDetailCurrentTitle => 'موجودہ خالص بقایا';

  @override
  String ledgerDetailOpeningLine(String amount) {
    return 'شروعاتی بیلنس: $amount';
  }

  @override
  String get ledgerDetailStatementTitle => 'اسٹیٹمنٹ (نیا پہلے)';

  @override
  String get ledgerKindOpening => 'شروعات';

  @override
  String get ledgerKindSaleOnCredit => 'ادھار فروخت';

  @override
  String get ledgerKindPurchaseOnCredit => 'ادھار خرید';

  @override
  String get ledgerKindPaymentReceived => 'رقم وصول';

  @override
  String get ledgerKindPaymentSent => 'رقم ادا';

  @override
  String get ledgerKindCreditNote => 'کریڈٹ نوٹ';

  @override
  String get ledgerKindDebitNote => 'ڈیبٹ نوٹ';

  @override
  String ledgerEntryDeltaLabel(String value) {
    return 'تبدیلی: $value';
  }

  @override
  String ledgerEntryBalanceAfter(String value) {
    return 'بعد: $value';
  }

  @override
  String get ledgerActionRecordMovement => 'نیا اندراج';

  @override
  String get ledgerRecordSheetTitle => 'نیا حرکت';

  @override
  String get ledgerFormKindLabel => 'قسم';

  @override
  String get ledgerFormAmountLabel => 'رقم (PKR)';

  @override
  String get ledgerFormAmountHint => 'مثلاً 50000';

  @override
  String get ledgerFormAmountInvalid => 'درست مثبت رقم لکھیں';

  @override
  String get ledgerFormNoteLabel => 'حوالہ (اختیاری)';

  @override
  String get ledgerFormNoteHint => 'انوائس #، چیک #…';

  @override
  String get ledgerFormCancel => 'منسوخ';

  @override
  String get ledgerFormSave => 'محفوظ';

  @override
  String get ledgerSnackRecorded => 'کھاتے میں محفوظ ہو گیا';

  @override
  String get ledgerDropdownSaleOnCredit => 'ادھار فروخت (ان کا قرض بڑھے)';

  @override
  String get ledgerDropdownPurchaseOnCredit => 'ادھار خرید (آپ کا قرض بڑھے)';

  @override
  String get ledgerDropdownPaymentReceived => 'ان سے رقم ملی';

  @override
  String get ledgerDropdownPaymentSent => 'ان کو رقم بھیجی';

  @override
  String get ledgerDropdownCreditNote => 'کریڈٹ نوٹ (آپ کے حق میں)';

  @override
  String get ledgerDropdownDebitNote => 'ڈیبٹ نوٹ (آپ پر)';

  @override
  String get ledgerMoveTitleSaleOnCredit => 'ادھار فروخت';

  @override
  String get ledgerMoveTitlePurchaseOnCredit => 'ادھار خرید';

  @override
  String get ledgerMoveTitlePaymentReceived => 'رقم وصول';

  @override
  String get ledgerMoveTitlePaymentSent => 'رقم ادا';

  @override
  String get ledgerMoveTitleCreditNote => 'کریڈٹ نوٹ';

  @override
  String get ledgerMoveTitleDebitNote => 'ڈیبٹ نوٹ';

  @override
  String get favoritesSubtitle =>
      'دل سے محفوظ آفرز، تاجر، اور لین دین — فلٹر، تلاش، کارڈ کھولیں یا ہٹائیں (ڈیمو؛ سرور سے منسلک نہیں)۔';

  @override
  String get favoritesSearchHint => 'عنوان، تاجر، یا قیمت تلاش…';

  @override
  String get favoritesFilterAll => 'سب';

  @override
  String get favoritesFilterOffers => 'آفرز';

  @override
  String get favoritesFilterTraders => 'تاجر';

  @override
  String get favoritesFilterTrades => 'لین دین';

  @override
  String get favoritesEmptyAll =>
      'ابھی کچھ محفوظ نہیں۔ منڈی میں دل کا نشان لگائیں۔';

  @override
  String get favoritesEmptyFilter => 'اس فلٹر یا تلاش میں کوئی پسندیدہ نہیں۔';

  @override
  String get favoritesKindOffer => 'آفر';

  @override
  String get favoritesKindTrader => 'تاجر';

  @override
  String get favoritesKindTrade => 'لین دین';

  @override
  String favoritesSavedOn(String date) {
    return 'محفوظ $date';
  }

  @override
  String get favoritesRemoveTitle => 'پسندیدہ ہٹائیں؟';

  @override
  String favoritesRemoveBody(String title) {
    return '“$title” محفوظ فہرست سے ہٹائیں؟';
  }

  @override
  String get favoritesRemoveCancel => 'منسوخ';

  @override
  String get favoritesRemoveConfirm => 'ہٹائیں';

  @override
  String get favoritesSnackRemoved => 'پسندیدہ سے ہٹا دیا گیا';

  @override
  String get favoritesDetailTitle => 'محفوظ شے';

  @override
  String get favoritesRemoveFromList => 'پسندیدہ سے ہٹائیں';

  @override
  String get chequesSubtitle =>
      'موصول یا جاری چیک — فلٹر، تلاش، کارروائی، وقت گزشت، نیا اندراج (ڈیمو)۔';

  @override
  String get chequesSearchHint => 'پارٹی، بینک، یا چیک # تلاش…';

  @override
  String get chequesFilterAll => 'سب';

  @override
  String get chequesFilterOutstanding => 'زیر التواء';

  @override
  String get chequesFilterClearing => 'کلیرنگ';

  @override
  String get chequesFilterCleared => 'کلئیر';

  @override
  String get chequesFilterBouncedOrCancelled => 'واپس / منسوخ';

  @override
  String get chequesEmptyList => 'اس فلٹر یا تلاش میں کوئی چیک نہیں۔';

  @override
  String get chequesDirectionReceived => 'موصول';

  @override
  String get chequesDirectionIssued => 'جاری';

  @override
  String get chequesStatusPending => 'زیر التواء';

  @override
  String get chequesStatusClearing => 'کلیرنگ میں';

  @override
  String get chequesStatusCleared => 'کلئیر';

  @override
  String get chequesStatusBounced => 'واپس';

  @override
  String get chequesStatusCancelled => 'منسوخ';

  @override
  String get chequesCardChequeNumber => 'چیک #';

  @override
  String chequesCardMatures(String date) {
    return 'ادائیگی $date';
  }

  @override
  String chequesDetailDates(String issue, String maturity) {
    return 'جاری $issue · ادائیگی $maturity';
  }

  @override
  String get chequesTimelineTitle => 'وقفے (نیا پہلے)';

  @override
  String get chequesEventKindRegistered => 'درج';

  @override
  String get chequesEventKindSentToBank => 'بینک میں';

  @override
  String get chequesEventKindCleared => 'کلئیر';

  @override
  String get chequesEventKindBounced => 'واپس';

  @override
  String get chequesEventKindCancelled => 'منسوخ';

  @override
  String get chequesEventKindNote => 'نوٹ';

  @override
  String get chequesActionSendToBank => 'بینک بھیجیں / پیش';

  @override
  String get chequesActionMarkCleared => 'کلئیر لکھیں';

  @override
  String get chequesActionMarkBounced => 'واپس لکھیں';

  @override
  String get chequesActionCancelCheque => 'چیک منسوخ';

  @override
  String get chequesActionAddNote => 'نوٹ شامل';

  @override
  String get chequesEventDepositTitle => 'آپ کے بینک میں کلیرنگ کے لیے جمع۔';

  @override
  String get chequesEventPresentedTitle => 'وصول کنندہ نے پیش کیا — کلیرنگ۔';

  @override
  String get chequesEventClearedTitle => 'کلئیر (ڈیمو)۔';

  @override
  String get chequesEventBouncedTitle => 'واپس / نامنظور (ڈیمو)۔';

  @override
  String get chequesEventCancelledTitle => 'چیک منسوخ (ڈیمو)۔';

  @override
  String get chequesEventNoteTitle => 'نوٹ شامل ہوا';

  @override
  String get chequesSnackSentToBank => 'کلیرنگ میں';

  @override
  String get chequesSnackCleared => 'کلئیر کر دیا';

  @override
  String get chequesSnackBounced => 'واپس کر دیا';

  @override
  String get chequesSnackCancelled => 'چیک منسوخ';

  @override
  String get chequesSnackNoteAdded => 'نوٹ محفوظ';

  @override
  String get chequesSnackRegistered => 'چیک درج ہو گیا';

  @override
  String get chequesDialogBounceTitle => 'واپس لکھیں؟';

  @override
  String get chequesDialogBounceBody =>
      'یہ ڈیمو میں نامنظور چیک ریکارڈ کرے گا۔';

  @override
  String get chequesDialogCancelTitle => 'چیک منسوخ؟';

  @override
  String get chequesDialogCancelBody => 'کلیرنگ سے پہلے منسوخی۔ صرف ڈیمو۔';

  @override
  String get chequesDialogNo => 'نہیں';

  @override
  String get chequesDialogYesBounce => 'واپس لکھیں';

  @override
  String get chequesDialogYesCancel => 'منسوخ کریں';

  @override
  String get chequesRegisterFab => 'نیا چیک';

  @override
  String get chequesRegisterTitle => 'چیک درج کریں';

  @override
  String get chequesRegisterDirection => 'سمت';

  @override
  String get chequesRegisterParty => 'پارٹی کا نام';

  @override
  String get chequesRegisterBank => 'بینک و شاخہ';

  @override
  String get chequesRegisterNumber => 'چیک نمبر';

  @override
  String get chequesRegisterAmount => 'رقم (PKR)';

  @override
  String get chequesRegisterAmountHint => 'مثلاً 125000';

  @override
  String get chequesRegisterAmountInvalid => 'درست مثبت رقم';

  @override
  String get chequesRegisterIssueDate => 'جاری تاریخ';

  @override
  String get chequesRegisterMaturityDate => 'ادائیگی کی تاریخ';

  @override
  String get chequesRegisterDateHint => 'YYYY-MM-DD';

  @override
  String get chequesRegisterNote => 'نوٹ (اختیاری)';

  @override
  String get chequesRegisterSubmit => 'محفوظ';

  @override
  String get chequesRegisterCancel => 'منسوخ';

  @override
  String get chequesRegisterEventLogged => 'مندی آن لائن میں چیک درج۔';

  @override
  String get chequesNoteSheetTitle => 'نوٹ شامل کریں';

  @override
  String get chequesNoteHint => 'حوالہ، فالو اپ…';

  @override
  String get chequesNoteSave => 'نوٹ محفوظ';

  @override
  String get tradeDetailBack => 'واپس';

  @override
  String get tradeDetailPerKg => 'فی کلو';

  @override
  String get tradeDetailPriceTotalHint => 'کل رقم';

  @override
  String get tradeDetailCategoryDryFruits => 'خشک میوہ';

  @override
  String get tradeDetailCategorySpices => 'مصالحے';

  @override
  String get tradeDetailCategoryNuts => 'گری دار میوے';

  @override
  String get tradeDetailCategoryHerbs => 'جڑی بوٹیاں';

  @override
  String tradeDetailRatingReviews(String rating, String count) {
    return '★ $rating · $count جائزے';
  }

  @override
  String get tradeDetailSoldByPrefix => 'فروخت کنندہ: ';

  @override
  String get tradeDetailSpecOrigin => 'اصل';

  @override
  String get tradeDetailSpecCropYear => 'فصل کا سال';

  @override
  String get tradeDetailSpecAvailable => 'دستیاب';

  @override
  String get tradeDetailBuyCash => 'نقد خرید';

  @override
  String get tradeDetailBuyCredit => 'ادھار خرید';

  @override
  String get tradeDetailOfferCash => 'پیشکش (نقد)';

  @override
  String get tradeDetailOfferCredit => 'پیشکش (ادھار)';

  @override
  String get tradeDetailSendQuotation => 'اقتباس بھیجیں';

  @override
  String get tradeDetailStartBargaining => 'مذاکرہ شروع';

  @override
  String get tradeDetailTrustShipping => 'مفت ترسیل';

  @override
  String get tradeDetailTrustQuality => 'معیار کی ضمانت';

  @override
  String get tradeDetailTrustChat => 'براہ راست چیٹ';

  @override
  String get tradeDetailDetailsTitle => 'تفصیل';

  @override
  String get tradeDetailFavoriteOn => 'پسندیدہ میں (ڈیمو)';

  @override
  String get tradeDetailFavoriteOff => 'پسندیدہ سے ہٹایا (ڈیمو)';

  @override
  String get tradeDetailActionDemo => 'کارروائی — صرف ڈیمو';

  @override
  String tradeDetailDescriptionBody(
    String product,
    String trader,
    String qty,
    String price,
    String year,
  ) {
    return '$product — $trader۔ مقدار $qty، قیمت $price۔ سال $year۔ ہول سیل کے لیے (ڈیمو)۔';
  }
}
