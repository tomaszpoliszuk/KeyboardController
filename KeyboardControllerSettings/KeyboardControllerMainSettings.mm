/* Keyboard Controller - Control Keyboard on iOS/iPadOS
 * (c) Copyright 2020-2023 Tomasz Poliszuk
 *
 * Keyboard Controller is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * Keyboard Controller is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Keyboard Controller. If not, see <https://www.gnu.org/licenses/>.
 */


#include "../headers.h"

NSMutableDictionary *tweakSettings;

@implementation KeyboardControllerMainSettings
- (PSSpecifier *)createGroupSpecifierNamed:(NSString *)name footer:(NSString *)footer key:(NSString *)key {
	PSSpecifier *specifier = [PSSpecifier groupSpecifierWithHeader:name footer:footer];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	return specifier;
}
- (PSSpecifier *)createSwitchSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue {
	PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:name
		target:self
		set:@selector(setPreferenceValue:specifier:)
		get:@selector(readPreferenceValue:)
		detail:nil
		cell:PSSwitchCell
		edit:nil
	];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	[specifier setProperty:defaultValue forKey:@"default"];
	[specifier setProperty:@kPackageName forKey:@"defaults"];
	[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
	return specifier;
}
- (PSSpecifier *)createSegmentSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue {
	PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:name
		target:self
		set:@selector(setPreferenceValue:specifier:)
		get:@selector(readPreferenceValue:)
		detail:nil
		cell:PSSegmentCell
		edit:nil
	];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	[specifier setProperty:defaultValue forKey:@"default"];
	[specifier setProperty:@kPackageName forKey:@"defaults"];
	[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
	[specifier setProperty:@"55" forKey:@"height"];
	return specifier;
}
- (PSSpecifier *)createLinkListSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue detail:(NSString *)detail {
	PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:name
		target:self
		set:@selector(setPreferenceValue:specifier:)
		get:@selector(readPreferenceValue:)
		detail:NSClassFromString(detail)
		cell:PSLinkListCell
		edit:nil
	];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	[specifier setProperty:defaultValue forKey:@"default"];
	[specifier setProperty:@kPackageName forKey:@"defaults"];
	[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
	return specifier;
}
- (PSTextFieldSpecifier *)createEditTextSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue {
	PSTextFieldSpecifier *specifier = [PSTextFieldSpecifier preferenceSpecifierNamed:name
		target:self
		set:@selector(setPreferenceValue:specifier:)
		get:@selector(readPreferenceValue:)
		detail:nil
		cell:PSEditTextCell
		edit:nil
	];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	[specifier setProperty:defaultValue forKey:@"default"];
	[specifier setProperty:@kPackageName forKey:@"defaults"];
	[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
	return specifier;
}
- (PSSpecifier *)createButtonSpecifierNamed:(NSString *)name {
	PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:name
		target:self
		set:nil
		get:nil
		detail:nil
		cell:PSButtonCell
		edit:nil
	];
	return specifier;
}
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [NSMutableArray new];

		PSSpecifier *enableTweak = [self createSwitchSpecifierNamed:@"Enable Tweak" key:@"enableTweak" default:@"1"];
		[enableTweak setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/KeyboardController.png"] forKey:@"iconImage"];
		[enableTweak setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:enableTweak];

		PSSpecifier *uiStyleGroup = [self createGroupSpecifierNamed:@"UI Style" footer:nil key:@"uiStyleGroup"];
		[_specifiers addObject:uiStyleGroup];

		PSSpecifier *uiStyle = [self createSegmentSpecifierNamed:@"UI Style" key:@"uiStyle" default:@"999"];
		[uiStyle setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Light", @"Dark" ]];
		[_specifiers addObject:uiStyle];

		PSSpecifier *selectTypesGroup = [self createGroupSpecifierNamed:@"Select Types" footer:nil key:@"selectTypesGroup"];
		[_specifiers addObject:selectTypesGroup];

		PSSpecifier *selectKeyboardType = [self createLinkListSpecifierNamed:@"Keyboard Type" key:@"selectKeyboardType" default:nil detail:@"KeyboardControllerKeyboardTypeSettings"];
		[_specifiers addObject:selectKeyboardType];

		PSSpecifier *selectTypesReturnKey = [self createLinkListSpecifierNamed:@"Return Key Type" key:@"selectTypesReturnKey" default:nil detail:@"KeyboardControllerReturnKeyTypeSettings"];
		[_specifiers addObject:selectTypesReturnKey];

		PSSpecifier *keyboardDismissModeGroup = [self createGroupSpecifierNamed:@"Swipe to dismiss keyboard" footer:@"Disabled:\nThe keyboard does not get dismissed with a drag.\n\nImmediately:\nThe keyboard is dismissed when a drag begins.\n\nInteractive:\nThe keyboard follows the dragging touch offscreen, and can be pulled upward again to cancel the dismiss." key:@"keyboardDismissModeGroup"];
		[_specifiers addObject:keyboardDismissModeGroup];

		PSSpecifier *keyboardDismissMode = [self createSegmentSpecifierNamed:@"" key:@"keyboardDismissMode" default:@"999"];
		[keyboardDismissMode setValues:@[ @"999", @"0", @"1", @"2" ] titles:@[ @"Default", @"Disabled", @"Immediately", @"Interactive" ]];
		[_specifiers addObject:keyboardDismissMode];

		if (@available(iOS 12, *)) {
			NSArray *trackpadModeTitles = @[ @"Default", @"Disabled", @"Spacebar only", @"Enabled" ];
			NSArray *trackpadModeValues = @[ @"999", @"404", @"505", @"1" ];

			if ( ![[UIDevice currentDevice] _supportsForceTouch] ) {
				trackpadModeTitles = @[ @"Default", @"Disabled", @"Spacebar only" ];
				trackpadModeValues = @[ @"999", @"404", @"505" ];
			}

			PSSpecifier *trackpadModeGroup = [self createGroupSpecifierNamed:@"Trackpad Mode" footer:nil key:@"trackpadModeGroup"];
			[_specifiers addObject:trackpadModeGroup];

			PSSpecifier *trackpadMode = [self createSegmentSpecifierNamed:@"" key:@"trackpadMode" default:@"999"];
			[trackpadMode setValues:trackpadModeValues titles:trackpadModeTitles];
			[_specifiers addObject:trackpadMode];
		}

		if (@available(iOS 10, *)) {
			PSSpecifier *dictationButtonGroup = [self createGroupSpecifierNamed:@"Dictation Button" footer:nil key:@"dictationButtonGroup"];
			[_specifiers addObject:dictationButtonGroup];

			PSSpecifier *dictationButton = [self createSegmentSpecifierNamed:@"dictationButton" key:@"dictationButton" default:@"999"];
			[dictationButton setValues:@[ @"999", @"0" ] titles:@[ @"Default", @"Disable" ]];
			[_specifiers addObject:dictationButton];
		}

		if (@available(iOS 11, *)) {
			PSSpecifier *shouldShowInternationalKeyGroup = [self createGroupSpecifierNamed:@"Globe Button" footer:nil key:@"shouldShowInternationalKeyGroup"];
			[_specifiers addObject:shouldShowInternationalKeyGroup];

			PSSpecifier *shouldShowInternationalKey = [self createSegmentSpecifierNamed:@"shouldShowInternationalKey" key:@"shouldShowInternationalKey" default:@"999"];
			[shouldShowInternationalKey setValues:@[ @"999", @"0" ] titles:@[ @"Default", @"Disable" ]];
			[_specifiers addObject:shouldShowInternationalKey];
		}

//		if (@available(iOS 8, *)) {
			PSSpecifier *returnKeyStylingGroup = [self createGroupSpecifierNamed:@"Return Key Styling" footer:nil key:@"returnKeyStylingGroup"];
			[_specifiers addObject:returnKeyStylingGroup];

			PSSpecifier *returnKeyStyling = [self createSegmentSpecifierNamed:@"returnKeyStyling" key:@"returnKeyStyling" default:@"999"];
			[returnKeyStyling setValues:@[ @"999", @"0", @"1" ] titles:@[ @"Default", @"Disable", @"Enable" ]];
			[_specifiers addObject:returnKeyStyling];
//		}

		PSSpecifier *selectingSkinToneForEmojiGroup = [self createGroupSpecifierNamed:@"Selecting skin tone for emoji" footer:nil key:@"selectingSkinToneForEmojiGroup"];
		[_specifiers addObject:selectingSkinToneForEmojiGroup];

		PSSpecifier *selectingSkinToneForEmoji = [self createSegmentSpecifierNamed:@"selectingSkinToneForEmoji" key:@"selectingSkinToneForEmoji" default:@"999"];
		[selectingSkinToneForEmoji setValues:@[ @"999", @"1" ] titles:@[ @"Default", @"Disable" ]];
		[_specifiers addObject:selectingSkinToneForEmoji];

		if ( [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad ) {
			PSSpecifier *emptyGroup = [PSSpecifier emptyGroupSpecifier];
			[_specifiers addObject:emptyGroup];

			PSSpecifier *betaOptions = [self createLinkListSpecifierNamed:@"Beta Options" key:@"betaOptions" default:nil detail:@"KeyboardControllerBetaOptions"];
			[_specifiers addObject:betaOptions];
		}

		NSArray *testKeyboardTitles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search" ];
		NSArray *testKeyboardValues = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10" ];

		if (@available(iOS 10, *)) {
			testKeyboardTitles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search", @"ASCII Capable Number Pad" ];
			testKeyboardValues = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11" ];
		}
		PSSpecifier *testKeyboardGroup = [self createGroupSpecifierNamed:@"Testing area" footer:nil key:@"testKeyboardGroup"];
		[_specifiers addObject:testKeyboardGroup];

		PSSpecifier *testKeyboardSelected = [self createLinkListSpecifierNamed:@"Test keyboard type:" key:@"testKeyboardSelected" default:@"0" detail:@"PSListItemsController"];
		[testKeyboardSelected setValues:testKeyboardValues titles:testKeyboardTitles];
		[_specifiers addObject:testKeyboardSelected];


		PSTextFieldSpecifier *testKeyboard = [self createEditTextSpecifierNamed:@"" key:@"testKeyboard" default:nil];
		[testKeyboard setPlaceholder:@"Test keyboard here"];
		static int testKeyboardSelectedValue = [[self readPreferenceValue:testKeyboardSelected] integerValue];
		[testKeyboard setKeyboardType:testKeyboardSelectedValue autoCaps:NO autoCorrection:NO];
		[_specifiers addObject:testKeyboard];

		for( PSSpecifier *specifier in _standardSpecifiers ) {
			[_specifiers addObject:specifier];
		}
	}
	return _specifiers;
}
- (instancetype)init {
	self = [super init];
	if (self) {
		[self createStandardSpecifiers];
	}
	return self;
}
- (void)createStandardSpecifiers {
	_standardSpecifiers = [NSMutableArray new];

	PSSpecifier *emptyGroup = [PSSpecifier emptyGroupSpecifier];
	[_standardSpecifiers addObject:emptyGroup];

	PSSpecifier *resetSettings = [self createButtonSpecifierNamed:@"Reset Settings"];
	resetSettings->action = @selector(resetSettings);

//	1 = left, 2 = center, 3 = right
	[resetSettings setProperty:@2 forKey:@"alignment"];
	[resetSettings setProperty:@YES forKey:@"hasIcon"];
	[_standardSpecifiers addObject:resetSettings];

	PSSpecifier* relatedLinks = [PSSpecifier groupSpecifierWithName:@"Related Links"];
	[_standardSpecifiers addObject:relatedLinks];

	PSSpecifier *sourceCode = [self createButtonSpecifierNamed:@"Source Code"];
	sourceCode->action = @selector(sourceCode);
	[sourceCode setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/code.png"] forKey:@"iconImage"];
	[sourceCode setProperty:@YES forKey:@"hasIcon"];
	[_standardSpecifiers addObject:sourceCode];

	PSSpecifier *knownIssues = [self createButtonSpecifierNamed:@"Known Issues"];
	knownIssues->action = @selector(knownIssues);
	[knownIssues setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/bug.png"] forKey:@"iconImage"];
	[knownIssues setProperty:@YES forKey:@"hasIcon"];
	[_standardSpecifiers addObject:knownIssues];

	PSSpecifier *linkBigboss = [self createButtonSpecifierNamed:@"Tomasz Poliszuk @ BigBoss"];
	linkBigboss->action = @selector(TomaszPoliszukAtBigBoss);
	[linkBigboss setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/packages.png"] forKey:@"iconImage"];
	[linkBigboss setProperty:@YES forKey:@"hasIcon"];
	[_standardSpecifiers addObject:linkBigboss];

	PSSpecifier *linkGithub = [self createButtonSpecifierNamed:@"Tomasz Poliszuk @ Github"];
	linkGithub->action = @selector(TomaszPoliszukAtGithub);
	[linkGithub setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/github.png"] forKey:@"iconImage"];
	[linkGithub setProperty:@YES forKey:@"hasIcon"];
	[_standardSpecifiers addObject:linkGithub];
}
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	[super setPreferenceValue:value specifier:specifier];

	PSSpecifier *testKeyboardSelected = [self specifierForID:@"testKeyboardSelected"];
	if (specifier == testKeyboardSelected) {
		PSSpecifier *testKeyboard = [self specifierForID:@"testKeyboard"];
		[testKeyboard setKeyboardType:[[self readPreferenceValue:testKeyboardSelected] integerValue] autoCaps:NO autoCorrection:NO];
		[self reloadSpecifier:testKeyboard];
	}
}
- (void)resetSettings {
	NSUserDefaults *tweakSettings = [[NSUserDefaults alloc] initWithSuiteName:@kPackageName];
	UIAlertController *resetSettingsAlert = [UIAlertController alertControllerWithTitle:@"Reset Keyboard Controller Settings" message:@"Do you want to reset settings?" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
		for(NSString *key in [[tweakSettings dictionaryRepresentation] allKeys]) {
			[tweakSettings removeObjectForKey:key];
		}
		[tweakSettings synchronize];
		[self reloadSpecifiers];
	}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[resetSettingsAlert addAction:cancel];
	[resetSettingsAlert addAction:confirm];
	[self presentViewController:resetSettingsAlert animated:YES completion:nil];
}
- (void)sourceCode {
	NSURL *sourceCode = [NSURL URLWithString:@"https://github.com/tomaszpoliszuk/KeyboardController"];
	[[UIApplication sharedApplication] openURL:sourceCode options:@{} completionHandler:nil];
}
- (void)knownIssues {
	NSURL *knownIssues = [NSURL URLWithString:@"https://github.com/tomaszpoliszuk/KeyboardController/issues"];
	[[UIApplication sharedApplication] openURL:knownIssues options:@{} completionHandler:nil];
}
- (void)TomaszPoliszukAtBigBoss {
	UIApplication *application = [UIApplication sharedApplication];
	NSString *tweakName = @"Keyboard Controller";
	tweakName = [tweakName stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	NSURL *packageDescriptionURL = [NSURL URLWithString:[@"http://apt.thebigboss.org/developer-packages.php?name=" stringByAppendingString:tweakName]];
	[application openURL:packageDescriptionURL options:@{} completionHandler:nil];
}
- (void)TomaszPoliszukAtGithub {
	UIApplication *application = [UIApplication sharedApplication];
	NSURL *githubProfileURL = [NSURL URLWithString:@"https://github.com/tomaszpoliszuk/"];
	[application openURL:githubProfileURL options:@{} completionHandler:nil];
}
@end
