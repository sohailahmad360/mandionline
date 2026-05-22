// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mandi Online';

  @override
  String get splashLoading => 'Loading…';

  @override
  String get homeTitle => 'Home';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get onboardingTitle => 'Welcome';

  @override
  String get tradesTitle => 'Trades';

  @override
  String get dealsTitle => 'Deals';

  @override
  String get messagesTitle => 'Messages';

  @override
  String get retry => 'Retry';

  @override
  String get signOut => 'Sign out';

  @override
  String get loginErrorInvalidCredentials =>
      'That email or password does not match the demo account. Use the exact values shown above, or tap Login as Guest.';

  @override
  String get loginSubtitle => 'Welcome back to your trading floor';

  @override
  String loginDemoCredentials(String email, String password) {
    return 'Demo: $email · $password';
  }

  @override
  String get emailOrPhoneLabel => 'Email or phone';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordComingSoon => 'Forgot password — coming soon';

  @override
  String get signInCta => 'Sign In';

  @override
  String get loginAsGuest => 'Login as Guest';

  @override
  String get languageSwitchToUrdu => 'اردو';

  @override
  String get languageSwitchToEnglish => 'EN';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get navHome => 'Home';

  @override
  String get navTrades => 'Trades';

  @override
  String get navDeals => 'Deals';

  @override
  String get navMessages => 'Messages';

  @override
  String get drawerGuest => 'Guest';

  @override
  String get drawerMemberDefault => 'Mandi member';

  @override
  String get drawerUserDefault => 'User';

  @override
  String get drawerBrowsingGuest => 'Browsing as guest';

  @override
  String get drawerSignedIn => 'Signed in';

  @override
  String get drawerProfile => 'Profile';

  @override
  String get drawerSettings => 'Settings';

  @override
  String get drawerOrderHistory => 'Order history';

  @override
  String get drawerHelp => 'Help & support';

  @override
  String get drawerLogout => 'Logout';

  @override
  String get comingSoonProfile => 'Profile — coming soon';

  @override
  String get comingSoonSettings => 'Settings — coming soon';

  @override
  String get comingSoonHistory => 'History — coming soon';

  @override
  String get comingSoonSupport => 'Support — coming soon';

  @override
  String get comingSoonCreateTrade => 'Create trade — coming soon';

  @override
  String get greetingMorning => 'Good morning 👋';

  @override
  String get guestHomeSubtitle => 'Browse categories & live offers';

  @override
  String get demoStoreSubtitle => 'Punjabi Store · Lahore';

  @override
  String get demoProfileName => 'Azhar Iqbal Awan';

  @override
  String get searchHintHome => 'Search spices, nuts, dry fruits…';

  @override
  String get dashboardStatTrades => 'Trades';

  @override
  String get dashboardStatDeals => 'Deals';

  @override
  String get dashboardStatLedgers => 'Ledgers';

  @override
  String get dashboardStatActiveOffers => 'Active offers';

  @override
  String get sectionTopCategories => 'Top categories';

  @override
  String get sectionLiveOffers => 'Live offers';

  @override
  String get sectionRecentTrades => 'Recent trades';

  @override
  String get viewAll => 'View all';

  @override
  String get categorySpices => 'Spices';

  @override
  String get categoryDryFruits => 'Dry fruits';

  @override
  String get categoryNuts => 'Nuts';

  @override
  String get categoryHerbs => 'Herbs';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get tradeLoadError => 'Could not load trades';

  @override
  String get noTradesYet => 'No trades yet';

  @override
  String get offerCategoryPakistan => 'Spices · Pakistan';

  @override
  String get offerCategoryGuatemala => 'Spices · Guatemala';

  @override
  String get offerCategoryIndia => 'Spices · India';

  @override
  String get productDriedRedChilies => 'Dried red chilies';

  @override
  String get productGreenCardamom => 'Green cardamom';

  @override
  String get productTurmericPowder => 'Turmeric powder';

  @override
  String get productBlackPepper => 'Black pepper (whole)';

  @override
  String get productCinnamonSticks => 'Cinnamon sticks';

  @override
  String get productClovesWhole => 'Cloves (whole)';

  @override
  String get priceLabel => 'Price';

  @override
  String get unitPerKg => '/kg';

  @override
  String get tradeBadgeSelling => 'SELLING';

  @override
  String get tradeBadgeBuying => 'BUYING';

  @override
  String get tradesScreenSubtitle => 'Manage your buying & selling trades';

  @override
  String get filterAll => 'All';

  @override
  String get filterBuying => 'Buying';

  @override
  String get filterSelling => 'Selling';

  @override
  String get filterButton => 'Filter';

  @override
  String get browseProducts => 'Browse products';

  @override
  String get browseRegionPakistan => 'Pakistan';

  @override
  String get browseRegionGuatemala => 'Guatemala';

  @override
  String get dealsScreenSubtitle => 'Active and completed transactions';

  @override
  String get dealSellingSummary => 'My selling deals';

  @override
  String get dealBuyingSummary => 'My buying deals';

  @override
  String get paymentLabel => 'Payment';

  @override
  String get shippingLabel => 'Shipping';

  @override
  String get invoiceLabel => 'Invoice';

  @override
  String get statusActive => 'Active';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusUnpaid => 'Unpaid';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get downloadInvoice => 'Download invoice';

  @override
  String get dealMessagesButton => 'Messages';

  @override
  String get raiseDispute => 'Raise dispute';

  @override
  String get messagesScreenSubtitle => 'Direct messages on your trades & deals';

  @override
  String get tabSelling => 'Selling';

  @override
  String get tabBuying => 'Buying';

  @override
  String get chatHeaderDeal => 'Deal #m1';

  @override
  String get chatParticipantSample => 'Karachi Wholesale';

  @override
  String get chatInputHint => 'Type a message…';

  @override
  String get genericError => 'Error';

  @override
  String get screenProfileTitle => 'Profile';

  @override
  String get screenSettingsTitle => 'Settings';

  @override
  String get screenOrderHistoryTitle => 'Order history';

  @override
  String get screenHelpSupportTitle => 'Help & support';

  @override
  String get profileGuestBanner =>
      'You are browsing as a guest. Sign in to sync your profile and orders.';

  @override
  String get profileSectionAccount => 'Account';

  @override
  String get profileLabelEmail => 'Email';

  @override
  String get profileEmailGuestPlaceholder => 'Available after sign-in';

  @override
  String get profileLabelPhone => 'Phone';

  @override
  String get profileDemoPhone => '+92 300 0000000';

  @override
  String get profileStoreRole => 'Verified store';

  @override
  String get profileEditProfile => 'Edit profile';

  @override
  String get profileEditComingSoon =>
      'Profile editing will be available in a future update.';

  @override
  String get settingsNotifications => 'Push notifications';

  @override
  String get settingsNotificationsSubtitle => 'Trade alerts and deal updates';

  @override
  String get settingsEmailDigest => 'Weekly email digest';

  @override
  String get settingsEmailDigestSubtitle => 'Summary of your mandi activity';

  @override
  String get settingsAppLanguage => 'App language';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageUrdu => 'Urdu';

  @override
  String get orderHistoryPlaced => 'Placed';

  @override
  String get orderHistoryOrder => 'Order';

  @override
  String get orderStatusProcessing => 'Processing';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get helpContactSection => 'Contact';

  @override
  String get helpSupportEmail => 'support@mandionline.pk';

  @override
  String get helpSupportPhone => '+92 800 000 0000';

  @override
  String get helpFaqOrdersTitle => 'How do I track an order?';

  @override
  String get helpFaqOrdersBody =>
      'Open Order history from the menu. Each row shows status and you can open the deal for shipment details.';

  @override
  String get helpFaqPaymentsTitle => 'When is payment captured?';

  @override
  String get helpFaqPaymentsBody =>
      'Funds are held in escrow until delivery is confirmed by both parties. This is a demo app — no real payments occur.';

  @override
  String get helpFaqDisputesTitle => 'How do I raise a dispute?';

  @override
  String get helpFaqDisputesBody =>
      'From a deal card, use Raise dispute. Our team will review within two business days (demo only).';

  @override
  String get listDetailOffersSubtitle =>
      'All live listings in this demo catalog';

  @override
  String get helpFaqHeading => 'FAQ';

  @override
  String get snackCopiedToClipboard => 'Copied to clipboard';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsEmpty => 'No notifications';

  @override
  String get notifDealUpdateTitle => 'Deal updated';

  @override
  String get notifDealUpdateBody =>
      'Your deal #4521 status changed to completed.';

  @override
  String get notifNewMessageTitle => 'New message';

  @override
  String get notifNewMessageBody =>
      'Karachi Wholesale sent a message on trade #4587.';

  @override
  String get notifPaymentTitle => 'Payment received';

  @override
  String get notifPaymentBody => 'Rs 168,000 was credited for deal #4500.';

  @override
  String get notifShipmentTitle => 'Shipment on the way';

  @override
  String get notifShipmentBody => 'Carrier picked up your order ORD-24089.';

  @override
  String get notifReminderTitle => 'Weekly summary';

  @override
  String get notifReminderBody =>
      'You have 3 active trades and 2 open deals this week.';

  @override
  String get createTradeTitle => 'New Trade';

  @override
  String get createTradeSubtitle =>
      'Create a buying or selling trade in 4 steps';

  @override
  String get createTradeSide => 'Side';

  @override
  String get createTradeBuying => 'Buy';

  @override
  String get createTradeSelling => 'Sell';

  @override
  String get createTradeProduct => 'Product';

  @override
  String get createTradeTrader => 'Counterparty / trader';

  @override
  String get createTradeQty => 'Quantity';

  @override
  String get createTradePrice => 'Price';

  @override
  String get createTradeSubmit => 'Create trade';

  @override
  String get createTradeSuccess => 'Trade created';

  @override
  String get createTradeProductHint => 'e.g. Dried red chilies';

  @override
  String get createTradeTraderHint => 'e.g. Karachi Wholesale';

  @override
  String get createTradeQtyHint => 'e.g. 500 kg';

  @override
  String get createTradePriceHint => 'e.g. Rs 390,000';

  @override
  String get newTradeBack => 'Back';

  @override
  String get newTradeNext => 'Next';

  @override
  String get newTradePublish => 'Publish trade';

  @override
  String get newTradeStep1 => 'Step 1';

  @override
  String get newTradeStep2 => 'Step 2';

  @override
  String get newTradeStep3 => 'Step 3';

  @override
  String get newTradeStep4 => 'Step 4';

  @override
  String get newTradeSectionCategory => 'Category';

  @override
  String get newTradeSectionQuantity => 'Quantity';

  @override
  String get newTradeSectionPricing => 'Pricing';

  @override
  String get newTradeSectionReview => 'Review';

  @override
  String get newTradeMainCategory => 'Main category';

  @override
  String get newTradeCategory => 'Category';

  @override
  String get newTradeSubCategory => 'Sub-category';

  @override
  String get newTradeType => 'Type';

  @override
  String get newTradeOrigin => 'Origin';

  @override
  String get newTradeCropYear => 'Crop year';

  @override
  String get newTradeQuantityKg => 'Quantity (kg)';

  @override
  String get newTradePackaging => 'Packaging';

  @override
  String get newTradeMinOrder => 'Min order';

  @override
  String get newTradeAvailableDate => 'Available date';

  @override
  String get newTradePricePerKg => 'Price per kg';

  @override
  String get newTradeCurrency => 'Currency';

  @override
  String get newTradePaymentTerms => 'Payment terms';

  @override
  String get newTradeDelivery => 'Delivery';

  @override
  String get newTradeReviewHint =>
      'Review your trade and publish to the marketplace.';

  @override
  String get newTradeReviewType => 'Type';

  @override
  String get newTradeReviewCategory => 'Category';

  @override
  String get newTradeReviewOrigin => 'Origin';

  @override
  String get newTradeReviewQuantity => 'Quantity';

  @override
  String get newTradeReviewPrice => 'Price';

  @override
  String get newTradeReviewTotal => 'Total';

  @override
  String get newTradeMarketplaceLabel => 'Marketplace';

  @override
  String get newTradeInvalidNumber => 'Enter a valid positive number';

  @override
  String get drawerItemUsers => 'Users';

  @override
  String get usersScreenSubtitle =>
      'People and businesses on the mandi — grouped by how they use the app.';

  @override
  String get usersTypeVerifiedStores => 'Verified stores (sellers)';

  @override
  String get usersTypeBuyersTraders => 'Buyers & traders';

  @override
  String get usersTypeGuests => 'Guests';

  @override
  String get usersTypeBrokers => 'Brokers & agents';

  @override
  String get usersTypeAdmins => 'Platform & support';

  @override
  String get usersVerifiedBadge => 'Verified';

  @override
  String get drawerItemQuotations => 'Quotations';

  @override
  String get quotationsScreenSubtitle =>
      'Formal price offers between parties — filter by status (demo data).';

  @override
  String get quotationIdPrefix => 'Quote';

  @override
  String get quotationIssued => 'Issued';

  @override
  String get quotationValidUntil => 'Valid until';

  @override
  String get quotationFrom => 'From';

  @override
  String get quotationTo => 'To';

  @override
  String get quotationStatusDraft => 'Draft';

  @override
  String get quotationStatusSent => 'Sent';

  @override
  String get quotationStatusAccepted => 'Accepted';

  @override
  String get quotationStatusRejected => 'Rejected';

  @override
  String get quotationStatusExpired => 'Expired';

  @override
  String get quotationsFilterAll => 'All';

  @override
  String get quotationsEmptyFilter => 'No quotations in this filter.';

  @override
  String get drawerItemBargaining => 'Bargaining';

  @override
  String get drawerItemLedgers => 'Ledgers';

  @override
  String get drawerItemCheques => 'Cheques';

  @override
  String get drawerItemFavorites => 'Favorites';

  @override
  String get modulePlaceholderBody =>
      'This module will be available in a future update.';

  @override
  String get bargainingSubtitle =>
      'Track price back-and-forth with counterparties. Open a thread to reply, counter, accept, or decline (demo session).';

  @override
  String get bargainingFilterAll => 'All';

  @override
  String get bargainingFilterActive => 'Active';

  @override
  String get bargainingFilterAgreed => 'Agreed';

  @override
  String get bargainingFilterDeclined => 'Declined';

  @override
  String get bargainingEmptyFilter => 'No negotiations in this filter.';

  @override
  String get bargainingWith => 'With';

  @override
  String get bargainingRoleBuying => 'You are buying';

  @override
  String get bargainingRoleSelling => 'You are selling';

  @override
  String get bargainingStatusActive => 'Active';

  @override
  String get bargainingStatusAgreed => 'Agreed';

  @override
  String get bargainingStatusDeclined => 'Declined';

  @override
  String get bargainingTimelineTitle => 'Timeline';

  @override
  String get bargainingActorYou => 'You';

  @override
  String get bargainingEventOpening => 'Offer';

  @override
  String get bargainingEventCounterBuyer => 'Buyer counter';

  @override
  String get bargainingEventCounterSeller => 'Seller counter';

  @override
  String get bargainingEventAccepted => 'Accepted';

  @override
  String get bargainingEventDeclined => 'Declined';

  @override
  String get bargainingEventSystem => 'Notice';

  @override
  String get bargainingActionCounter => 'Counter-offer';

  @override
  String get bargainingActionAccept => 'Accept';

  @override
  String get bargainingActionDecline => 'Decline';

  @override
  String get bargainingCounterTitle => 'Your counter-offer';

  @override
  String get bargainingCounterAmountLabel => 'Price / terms';

  @override
  String get bargainingCounterAmountHint => 'e.g. Rs 750 / kg';

  @override
  String get bargainingCounterNoteLabel => 'Note (optional)';

  @override
  String get bargainingCounterNoteHint => 'Explain your position…';

  @override
  String get bargainingCounterCancel => 'Cancel';

  @override
  String get bargainingCounterSubmit => 'Send counter';

  @override
  String get bargainingCounterDefaultNote => 'Updated offer.';

  @override
  String get bargainingSnackCounterPosted => 'Counter-offer sent';

  @override
  String get bargainingSnackAccepted =>
      'You accepted — move to deal when ready';

  @override
  String get bargainingSnackDeclined => 'Negotiation closed';

  @override
  String get ledgerSubtitle =>
      'Running balances with buyers and sellers — filter, search, open a party statement, and record movements (demo session).';

  @override
  String get ledgerSearchHint => 'Search party name…';

  @override
  String get ledgerFilterAll => 'All';

  @override
  String get ledgerFilterReceivable => 'They owe';

  @override
  String get ledgerFilterPayable => 'You owe';

  @override
  String get ledgerFilterSettled => 'Settled';

  @override
  String get ledgerEmptyList => 'No ledgers match this filter or search.';

  @override
  String get ledgerCardBalanceLabel => 'Net position';

  @override
  String ledgerBalanceTheyOwe(String amount) {
    return 'They owe $amount';
  }

  @override
  String ledgerBalanceYouOwe(String amount) {
    return 'You owe $amount';
  }

  @override
  String get ledgerBalanceSettledShort => 'Settled (even)';

  @override
  String get ledgerSideSettled => 'Settled';

  @override
  String get ledgerSideReceivable => 'Receivable';

  @override
  String get ledgerSidePayable => 'Payable';

  @override
  String get ledgerDetailCurrentTitle => 'Current net balance';

  @override
  String ledgerDetailOpeningLine(String amount) {
    return 'Opening balance carried in: $amount';
  }

  @override
  String get ledgerDetailStatementTitle => 'Statement (newest first)';

  @override
  String get ledgerKindOpening => 'Opening';

  @override
  String get ledgerKindSaleOnCredit => 'Sale on credit';

  @override
  String get ledgerKindPurchaseOnCredit => 'Purchase on credit';

  @override
  String get ledgerKindPaymentReceived => 'Payment received';

  @override
  String get ledgerKindPaymentSent => 'Payment sent';

  @override
  String get ledgerKindCreditNote => 'Credit note';

  @override
  String get ledgerKindDebitNote => 'Debit note';

  @override
  String ledgerEntryDeltaLabel(String value) {
    return 'Change: $value';
  }

  @override
  String ledgerEntryBalanceAfter(String value) {
    return 'After: $value';
  }

  @override
  String get ledgerActionRecordMovement => 'Record movement';

  @override
  String get ledgerRecordSheetTitle => 'Record a movement';

  @override
  String get ledgerFormKindLabel => 'Movement type';

  @override
  String get ledgerFormAmountLabel => 'Amount (PKR)';

  @override
  String get ledgerFormAmountHint => 'e.g. 50000';

  @override
  String get ledgerFormAmountInvalid => 'Enter a valid positive amount';

  @override
  String get ledgerFormNoteLabel => 'Reference (optional)';

  @override
  String get ledgerFormNoteHint => 'Invoice #, cheque #, lot id…';

  @override
  String get ledgerFormCancel => 'Cancel';

  @override
  String get ledgerFormSave => 'Save';

  @override
  String get ledgerSnackRecorded => 'Movement saved to this ledger';

  @override
  String get ledgerDropdownSaleOnCredit => 'Sale on credit (they owe more)';

  @override
  String get ledgerDropdownPurchaseOnCredit =>
      'Purchase on credit (you owe more)';

  @override
  String get ledgerDropdownPaymentReceived => 'Payment received from them';

  @override
  String get ledgerDropdownPaymentSent => 'Payment you sent to them';

  @override
  String get ledgerDropdownCreditNote => 'Credit note (in your favour)';

  @override
  String get ledgerDropdownDebitNote => 'Debit note (against you)';

  @override
  String get ledgerMoveTitleSaleOnCredit => 'Sale on credit';

  @override
  String get ledgerMoveTitlePurchaseOnCredit => 'Purchase on credit';

  @override
  String get ledgerMoveTitlePaymentReceived => 'Payment received';

  @override
  String get ledgerMoveTitlePaymentSent => 'Payment sent';

  @override
  String get ledgerMoveTitleCreditNote => 'Credit note';

  @override
  String get ledgerMoveTitleDebitNote => 'Debit note';

  @override
  String get favoritesSubtitle =>
      'Offers, traders, and trades you marked with the heart — filter, search, open a card, or remove (demo session; not synced to a server yet).';

  @override
  String get favoritesSearchHint => 'Search title, trader, or price…';

  @override
  String get favoritesFilterAll => 'All';

  @override
  String get favoritesFilterOffers => 'Offers';

  @override
  String get favoritesFilterTraders => 'Traders';

  @override
  String get favoritesFilterTrades => 'Trades';

  @override
  String get favoritesEmptyAll =>
      'Nothing saved yet. Heart items from the mandi to see them here.';

  @override
  String get favoritesEmptyFilter =>
      'No favorites match this filter or search.';

  @override
  String get favoritesKindOffer => 'Offer';

  @override
  String get favoritesKindTrader => 'Trader';

  @override
  String get favoritesKindTrade => 'Trade';

  @override
  String favoritesSavedOn(String date) {
    return 'Saved $date';
  }

  @override
  String get favoritesRemoveTitle => 'Remove favorite?';

  @override
  String favoritesRemoveBody(String title) {
    return 'Remove “$title” from your saved list?';
  }

  @override
  String get favoritesRemoveCancel => 'Cancel';

  @override
  String get favoritesRemoveConfirm => 'Remove';

  @override
  String get favoritesSnackRemoved => 'Removed from favorites';

  @override
  String get favoritesDetailTitle => 'Saved item';

  @override
  String get favoritesRemoveFromList => 'Remove from favorites';

  @override
  String get chequesSubtitle =>
      'Track cheques you received or issued — filters, search, lifecycle actions, timeline, and register new instruments (demo session).';

  @override
  String get chequesSearchHint => 'Search party, bank, or cheque #…';

  @override
  String get chequesFilterAll => 'All';

  @override
  String get chequesFilterOutstanding => 'Pending';

  @override
  String get chequesFilterClearing => 'In clearing';

  @override
  String get chequesFilterCleared => 'Cleared';

  @override
  String get chequesFilterBouncedOrCancelled => 'Bounced / void';

  @override
  String get chequesEmptyList => 'No cheques match this filter or search.';

  @override
  String get chequesDirectionReceived => 'Received';

  @override
  String get chequesDirectionIssued => 'Issued';

  @override
  String get chequesStatusPending => 'Pending';

  @override
  String get chequesStatusClearing => 'In clearing';

  @override
  String get chequesStatusCleared => 'Cleared';

  @override
  String get chequesStatusBounced => 'Bounced';

  @override
  String get chequesStatusCancelled => 'Void';

  @override
  String get chequesCardChequeNumber => 'Cheque #';

  @override
  String chequesCardMatures(String date) {
    return 'Matures $date';
  }

  @override
  String chequesDetailDates(String issue, String maturity) {
    return 'Issued $issue · Matures $maturity';
  }

  @override
  String get chequesTimelineTitle => 'Timeline (newest first)';

  @override
  String get chequesEventKindRegistered => 'Registered';

  @override
  String get chequesEventKindSentToBank => 'With bank';

  @override
  String get chequesEventKindCleared => 'Cleared';

  @override
  String get chequesEventKindBounced => 'Bounced';

  @override
  String get chequesEventKindCancelled => 'Voided';

  @override
  String get chequesEventKindNote => 'Note';

  @override
  String get chequesActionSendToBank => 'Send to bank / presented';

  @override
  String get chequesActionMarkCleared => 'Mark cleared';

  @override
  String get chequesActionMarkBounced => 'Mark bounced';

  @override
  String get chequesActionCancelCheque => 'Void cheque';

  @override
  String get chequesActionAddNote => 'Add note';

  @override
  String get chequesEventDepositTitle =>
      'Deposited with your bank for clearing.';

  @override
  String get chequesEventPresentedTitle => 'Payee presented — under clearing.';

  @override
  String get chequesEventClearedTitle => 'Marked cleared (demo).';

  @override
  String get chequesEventBouncedTitle => 'Marked bounced / dishonoured (demo).';

  @override
  String get chequesEventCancelledTitle => 'Cheque voided (demo).';

  @override
  String get chequesEventNoteTitle => 'Note added';

  @override
  String get chequesSnackSentToBank => 'Status updated — in clearing';

  @override
  String get chequesSnackCleared => 'Marked cleared';

  @override
  String get chequesSnackBounced => 'Marked bounced';

  @override
  String get chequesSnackCancelled => 'Cheque voided';

  @override
  String get chequesSnackNoteAdded => 'Note saved on this cheque';

  @override
  String get chequesSnackRegistered => 'Cheque registered';

  @override
  String get chequesDialogBounceTitle => 'Mark as bounced?';

  @override
  String get chequesDialogBounceBody =>
      'This records a dishonoured cheque for this demo session.';

  @override
  String get chequesDialogCancelTitle => 'Void this cheque?';

  @override
  String get chequesDialogCancelBody =>
      'Use when the instrument is cancelled before clearing. Demo only.';

  @override
  String get chequesDialogNo => 'No';

  @override
  String get chequesDialogYesBounce => 'Mark bounced';

  @override
  String get chequesDialogYesCancel => 'Void cheque';

  @override
  String get chequesRegisterFab => 'Register cheque';

  @override
  String get chequesRegisterTitle => 'Register a cheque';

  @override
  String get chequesRegisterDirection => 'Direction';

  @override
  String get chequesRegisterParty => 'Party name';

  @override
  String get chequesRegisterBank => 'Bank & branch';

  @override
  String get chequesRegisterNumber => 'Cheque number';

  @override
  String get chequesRegisterAmount => 'Amount (PKR)';

  @override
  String get chequesRegisterAmountHint => 'e.g. 125000';

  @override
  String get chequesRegisterAmountInvalid => 'Enter a valid positive amount';

  @override
  String get chequesRegisterIssueDate => 'Issue date';

  @override
  String get chequesRegisterMaturityDate => 'Maturity / value date';

  @override
  String get chequesRegisterDateHint => 'YYYY-MM-DD';

  @override
  String get chequesRegisterNote => 'Note (optional)';

  @override
  String get chequesRegisterSubmit => 'Save';

  @override
  String get chequesRegisterCancel => 'Cancel';

  @override
  String get chequesRegisterEventLogged => 'Cheque registered in Mandi Online.';

  @override
  String get chequesNoteSheetTitle => 'Add a note';

  @override
  String get chequesNoteHint => 'Reference, follow-up, bank officer…';

  @override
  String get chequesNoteSave => 'Save note';

  @override
  String get tradeDetailBack => 'Back';

  @override
  String get tradeDetailPerKg => 'per kg';

  @override
  String get tradeDetailPriceTotalHint => 'listed total';

  @override
  String get tradeDetailCategoryDryFruits => 'Dry Fruits';

  @override
  String get tradeDetailCategorySpices => 'Spices';

  @override
  String get tradeDetailCategoryNuts => 'Nuts';

  @override
  String get tradeDetailCategoryHerbs => 'Herbs';

  @override
  String tradeDetailRatingReviews(String rating, String count) {
    return '★ $rating · $count reviews';
  }

  @override
  String get tradeDetailSoldByPrefix => 'Sold by: ';

  @override
  String get tradeDetailSpecOrigin => 'Origin';

  @override
  String get tradeDetailSpecCropYear => 'Crop year';

  @override
  String get tradeDetailSpecAvailable => 'Available';

  @override
  String get tradeDetailBuyCash => 'Buy Cash';

  @override
  String get tradeDetailBuyCredit => 'Buy Credit';

  @override
  String get tradeDetailOfferCash => 'Offer (cash)';

  @override
  String get tradeDetailOfferCredit => 'Offer (credit)';

  @override
  String get tradeDetailSendQuotation => 'Send quotation';

  @override
  String get tradeDetailStartBargaining => 'Start bargaining';

  @override
  String get tradeDetailTrustShipping => 'Free shipping';

  @override
  String get tradeDetailTrustQuality => 'Quality assured';

  @override
  String get tradeDetailTrustChat => 'Direct chat';

  @override
  String get tradeDetailDetailsTitle => 'Details';

  @override
  String get tradeDetailFavoriteOn => 'Saved to favorites (demo)';

  @override
  String get tradeDetailFavoriteOff => 'Removed from favorites (demo)';

  @override
  String get tradeDetailActionDemo => 'Action — demo only';

  @override
  String tradeDetailDescriptionBody(
    String product,
    String trader,
    String qty,
    String price,
    String year,
  ) {
    return '$product from $trader. Quantity $qty at $price. Crop year $year. Graded for wholesale on Mandi Online (demo listing).';
  }
}
