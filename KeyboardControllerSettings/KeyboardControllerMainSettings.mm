/* Keyboard Controller - Control Keyboard on iOS/iPadOS
 * Copyright (C) 2020 Tomasz Poliszuk
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


#include "headers.h"

#define userSettingsFile @"/var/mobile/Library/Preferences/com.tomaszpoliszuk.keyboardcontroller.plist"
#define packageName "com.tomaszpoliszuk.keyboardcontroller"

NSMutableDictionary *tweakSettings;

@implementation KeyboardControllerMainSettings
- (NSArray *)specifiers {
	if (!_specifiers) {

		_specifiers = [NSMutableArray new];

		PSSpecifier* emptyGroup = [PSSpecifier emptyGroupSpecifier];

		PSSpecifier *enableTweak = [PSSpecifier preferenceSpecifierNamed:@"Enable Tweak"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSSwitchCell
			edit:nil
		];
		[enableTweak setProperty:@"YES" forKey:@"default"];
		[enableTweak setProperty:@"enableTweak" forKey:@"key"];
		[enableTweak setProperty:@"Enable Tweak" forKey:@"label"];
		[enableTweak setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/KeyboardController.png"] forKey:@"iconImage"];
		[enableTweak setProperty:kPackage forKey:@"defaults"];
		[enableTweak setProperty:@"1" forKey:@"default"];
		[enableTweak setProperty:kSettingsChanged forKey:@"PostNotification"];
		[enableTweak setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:enableTweak];

		PSSpecifier* uiStyleGroup = [PSSpecifier groupSpecifierWithName:@"UI Style"];
		[uiStyleGroup setProperty:@"uiStyleGroup" forKey:@"key"];
		[_specifiers addObject:uiStyleGroup];

		PSSpecifier *uiStyle = [PSSpecifier preferenceSpecifierNamed:@"UI Style"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSSegmentCell
			edit:nil
		];
		[uiStyle setProperty:@"999" forKey:@"default"];
		[uiStyle setProperty:@"uiStyle" forKey:@"key"];
		[uiStyle setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Light", @"Dark" ]];
		[uiStyle setProperty:kPackage forKey:@"defaults"];
		[uiStyle setProperty:kSettingsChanged forKey:@"PostNotification"];
		[uiStyle setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:uiStyle];

		PSSpecifier* keyboardDismissModeGroup = [PSSpecifier groupSpecifierWithName:@"Swipe to dismiss keyboard"];
		[keyboardDismissModeGroup setProperty:@"keyboardDismissModeGroup" forKey:@"key"];
		[_specifiers addObject:keyboardDismissModeGroup];

		PSSpecifier *keyboardDismissMode = [PSSpecifier preferenceSpecifierNamed:@"keyboardDismissMode"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSSegmentCell
			edit:nil
		];
		[keyboardDismissMode setProperty:@"999" forKey:@"default"];
		[keyboardDismissMode setProperty:@"keyboardDismissMode" forKey:@"key"];
		[keyboardDismissMode setValues:@[ @"999", @"0", @"1", @"2" ] titles:@[ @"Default", @"Disabled", @"Immediately", @"Interactive" ]];
		[keyboardDismissMode setProperty:kPackage forKey:@"defaults"];
		[keyboardDismissMode setProperty:kSettingsChanged forKey:@"PostNotification"];
		[keyboardDismissMode setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:keyboardDismissMode];

		if (@available(iOS 12, *)) {
			NSArray *trackpadModeTitles = @[ @"Default", @"Disabled", @"Spacebar only", @"Enabled" ];
			NSArray *trackpadModeValues = @[ @"999", @"404", @"505", @"1" ];

			if ( ![[UIDevice currentDevice] _supportsForceTouch] ) {
				trackpadModeTitles = @[ @"Default", @"Disabled", @"Spacebar only" ];
				trackpadModeValues = @[ @"999", @"404", @"505" ];
			}

			PSSpecifier* trackpadModeGroup = [PSSpecifier groupSpecifierWithName:@"Trackpad Mode"];
			[trackpadModeGroup setProperty:@"trackpadModeGroup" forKey:@"key"];

			[_specifiers addObject:trackpadModeGroup];

			PSSpecifier *trackpadMode = [PSSpecifier preferenceSpecifierNamed:@"trackpadMode"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSSegmentCell
				edit:nil
			];
			[trackpadMode setProperty:@"999" forKey:@"default"];
			[trackpadMode setProperty:@"trackpadMode" forKey:@"key"];
			[trackpadMode setValues:trackpadModeValues titles:trackpadModeTitles];
			[trackpadMode setProperty:kPackage forKey:@"defaults"];
			[trackpadMode setProperty:kSettingsChanged forKey:@"PostNotification"];
			[trackpadMode setProperty:@"55" forKey:@"height"];

			[_specifiers addObject:trackpadMode];
		}

		if (@available(iOS 13, *)) {
			if ( [[UIDevice currentDevice] respondsToSelector:@selector(_tapticEngine)] ) {
				PSSpecifier* feedbackGroup = [PSSpecifier groupSpecifierWithName:@"Haptic Feedback"];
				[_specifiers addObject:feedbackGroup];

				NSArray *feedbackTypeTitles = @[ @"Disabled", @"selection", @"Light", @"Medium", @"Heavy", @"Soft", @"Rigid" ];
				NSArray *feedbackTypeValues = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6" ];

				NSArray *feedbackWhenTitles = @[ @"start", @"end" ];
				NSArray *feedbackWhenValues = @[ @"0", @"1" ];

				PSSpecifier *feedbackType = [PSSpecifier preferenceSpecifierNamed:@"Haptic type:"
					target:self
					set:@selector(setPreferenceValue:specifier:)
					get:@selector(readPreferenceValue:)
					detail:NSClassFromString(@"PSListItemsController")
					cell:PSLinkListCell
					edit:nil
				];
				[feedbackType setProperty:@"0" forKey:@"default"];
				[feedbackType setProperty:@"feedbackType" forKey:@"key"];
				[feedbackType setValues:feedbackTypeValues titles:feedbackTypeTitles];
				[feedbackType setProperty:kPackage forKey:@"defaults"];
				[feedbackType setProperty:kSettingsChanged forKey:@"PostNotification"];
				[feedbackType setProperty:@"55" forKey:@"height"];
				[feedbackType setProperty:@"feedbackType" forKey:@"id"];
				[_specifiers addObject:feedbackType];

				PSSpecifier *feedbackWhen = [PSSpecifier preferenceSpecifierNamed:@"Select feedback type:"
					target:self
					set:@selector(setPreferenceValue:specifier:)
					get:@selector(readPreferenceValue:)
					detail:NSClassFromString(@"PSListItemsController")
					cell:PSLinkListCell
					edit:nil
				];
				[feedbackWhen setProperty:@"0" forKey:@"default"];
				[feedbackWhen setProperty:@"feedbackWhen" forKey:@"key"];
				[feedbackWhen setValues:feedbackWhenValues titles:feedbackWhenTitles];
				[feedbackWhen setProperty:kPackage forKey:@"defaults"];
				[feedbackWhen setProperty:kSettingsChanged forKey:@"PostNotification"];
				[feedbackWhen setProperty:@"55" forKey:@"height"];
				[feedbackWhen setProperty:@"feedbackWhen" forKey:@"id"];
				[_specifiers addObject:feedbackWhen];
			}
		}

		PSSpecifier* selectTypesGroup = [PSSpecifier groupSpecifierWithName:@"Select Types"];
		[selectTypesGroup setProperty:@"selectTypesGroup" forKey:@"key"];
		[_specifiers addObject:selectTypesGroup];

		PSSpecifier* selectKeyboardType = [PSSpecifier preferenceSpecifierNamed:@"Edit Keyboard Type"
			target:self
			set:NULL
			get:NULL
			detail:NSClassFromString(@"KeyboardControllerKeyboardTypeSettings")
			cell:PSLinkCell
			edit:Nil
		];
		[_specifiers addObject:selectKeyboardType];

		PSSpecifier* selectTypesReturnKey = [PSSpecifier preferenceSpecifierNamed:@"Edit Return Key Type"
			target:self
			set:NULL
			get:NULL
			detail:NSClassFromString(@"KeyboardControllerReturnKeyTypeSettings")
			cell:PSLinkCell
			edit:Nil
		];
		[_specifiers addObject:selectTypesReturnKey];

		PSSpecifier* keyboardOptions = [PSSpecifier preferenceSpecifierNamed:@"Other Options"
			target:self
			set:NULL
			get:NULL
			detail:NSClassFromString(@"KeyboardControllerKeyboardOptions")
			cell:PSLinkCell
			edit:Nil
		];
		[_specifiers addObject:keyboardOptions];

		PSSpecifier* betaOptions = [PSSpecifier preferenceSpecifierNamed:@"Beta Options"
			target:self
			set:NULL
			get:NULL
			detail:NSClassFromString(@"KeyboardControllerBetaOptions")
			cell:PSLinkCell
			edit:Nil
		];
		[_specifiers addObject:betaOptions];

		NSArray *testKeyboardTitles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search" ];
		NSArray *testKeyboardValues = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10" ];

		if (@available(iOS 10, *)) {
			testKeyboardTitles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search", @"ASCII Capable Number Pad" ];
			testKeyboardValues = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11" ];
		}

		PSSpecifier* testKeyboardGroup = [PSSpecifier groupSpecifierWithName:@"Testing area"];
		[_specifiers addObject:testKeyboardGroup];

		PSSpecifier *testKeyboardSelected = [PSSpecifier preferenceSpecifierNamed:@"Test keyboard type:"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[testKeyboardSelected setProperty:@"0" forKey:@"default"];
		[testKeyboardSelected setProperty:@"testKeyboardSelected" forKey:@"key"];
		[testKeyboardSelected setValues:testKeyboardValues titles:testKeyboardTitles];
		[testKeyboardSelected setProperty:kPackage forKey:@"defaults"];
		[testKeyboardSelected setProperty:kSettingsChanged forKey:@"PostNotification"];
		[testKeyboardSelected setProperty:@"55" forKey:@"height"];
		[testKeyboardSelected setProperty:@"testKeyboardSelected" forKey:@"id"];
		[_specifiers addObject:testKeyboardSelected];

		PSTextFieldSpecifier *testKeyboard = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[testKeyboard setProperty:@"testKeyboard" forKey:@"id"];
		[testKeyboard setPlaceholder:@"Test keyboard here"];

		static int testKeyboardSelectedValue = [[self readPreferenceValue:testKeyboardSelected] integerValue];

		[testKeyboard setKeyboardType:testKeyboardSelectedValue autoCaps:NO autoCorrection:NO];

		[_specifiers addObject:testKeyboard];

		[_specifiers addObject:emptyGroup];

		PSSpecifier *resetSettings = [PSSpecifier preferenceSpecifierNamed:@"Reset Settings"
			target:self
			set:nil
			get:nil
			detail:nil
			cell:PSButtonCell
			edit:nil
		];
		resetSettings->action = @selector(resetSettings);
		[resetSettings setProperty:@"center" forKey:@"textAlignment"];
		[resetSettings setProperty:@YES forKey:@"hasIcon"];
		[_specifiers addObject:resetSettings];

		PSSpecifier* relatedLinks = [PSSpecifier groupSpecifierWithName:@"Related Links"];
		[_specifiers addObject:relatedLinks];

		PSSpecifier *sourceCode = [PSSpecifier preferenceSpecifierNamed:@"Source Code"
			target:self
			set:nil
			get:nil
			detail:nil
			cell:PSButtonCell
			edit:nil
		];
		sourceCode->action = @selector(sourceCode);
		[sourceCode setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/code.png"] forKey:@"iconImage"];
		[sourceCode setProperty:@YES forKey:@"hasIcon"];
		[_specifiers addObject:sourceCode];

		PSSpecifier *knownIssues = [PSSpecifier preferenceSpecifierNamed:@"Known Issues"
			target:self
			set:nil
			get:nil
			detail:nil
			cell:PSButtonCell
			edit:nil
		];
		knownIssues->action = @selector(knownIssues);
		[knownIssues setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/bug.png"] forKey:@"iconImage"];
		[knownIssues setProperty:@YES forKey:@"hasIcon"];
		[_specifiers addObject:knownIssues];

		PSSpecifier *linkBigboss = [PSSpecifier preferenceSpecifierNamed:@"Tomasz Poliszuk @ BigBoss"
			target:self
			set:nil
			get:nil
			detail:nil
			cell:PSButtonCell
			edit:nil
		];
		linkBigboss->action = @selector(TomaszPoliszukAtBigBoss);
		[linkBigboss setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/packages.png"] forKey:@"iconImage"];
		[linkBigboss setProperty:@YES forKey:@"hasIcon"];
		[_specifiers addObject:linkBigboss];

		PSSpecifier *linkGithub = [PSSpecifier preferenceSpecifierNamed:@"Tomasz Poliszuk @ Github"
			target:self
			set:nil
			get:nil
			detail:nil
			cell:PSButtonCell
			edit:nil
		];
		linkGithub->action = @selector(TomaszPoliszukAtGithub);
		[linkGithub setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/github.png"] forKey:@"iconImage"];
		[linkGithub setProperty:@YES forKey:@"hasIcon"];
		[_specifiers addObject:linkGithub];

		PSSpecifier *linkTwitter = [PSSpecifier preferenceSpecifierNamed:@"Tomasz Poliszuk @ Twitter"
			target:self
			set:nil
			get:nil
			detail:nil
			cell:PSButtonCell
			edit:nil
		];
		linkTwitter->action = @selector(TomaszPoliszukAtTwitter);
		[linkTwitter setProperty:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/KeyboardControllerSettings.bundle/icons/twitter.png"] forKey:@"iconImage"];
		[linkTwitter setProperty:@YES forKey:@"hasIcon"];
		[_specifiers addObject:linkTwitter];
	}
	return _specifiers;
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
	NSUserDefaults *tweakSettings = [[NSUserDefaults alloc] initWithSuiteName:domainString];
	UIAlertController *resetSettingsAlert = [UIAlertController alertControllerWithTitle:@"Reset Keyboard Controller Settings" message:@"Do you want to reset settings?" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		for(NSString* key in [[tweakSettings dictionaryRepresentation] allKeys]) {
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
	NSURL *twitterWebsite = [NSURL URLWithString:[@"http://apt.thebigboss.org/developer-packages.php?name=" stringByAppendingString:tweakName]];
	[application openURL:twitterWebsite options:@{} completionHandler:nil];
}
- (void)TomaszPoliszukAtGithub {
	UIApplication *application = [UIApplication sharedApplication];
	NSString *username = @"tomaszpoliszuk";
	NSURL *githubWebsite = [NSURL URLWithString:[@"https://github.com/" stringByAppendingString:username]];
	[application openURL:githubWebsite options:@{} completionHandler:nil];
}
- (void)TomaszPoliszukAtTwitter {
	UIApplication *application = [UIApplication sharedApplication];
	NSString *username = @"tomaszpoliszuk";
	NSURL *twitterWebsite = [NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:username]];
	[application openURL:twitterWebsite options:@{} completionHandler:nil];
}
@end
