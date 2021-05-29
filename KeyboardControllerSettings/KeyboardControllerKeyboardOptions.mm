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

@implementation KeyboardControllerKeyboardOptions
- (NSArray *)specifiers {
	if ( !_specifiers ) {

		_specifiers = [NSMutableArray new];

		if (@available(iOS 10, *)) {
//		if (kIsiOS10AndUp) {
			PSSpecifier* dictationButtonGroup = [PSSpecifier groupSpecifierWithName:@"Dictation Button"];
			[dictationButtonGroup setProperty:@"dictationButtonGroup" forKey:@"key"];
			[_specifiers addObject:dictationButtonGroup];

			PSSpecifier *dictationButton = [PSSpecifier preferenceSpecifierNamed:@"dictationButton"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSSegmentCell
				edit:nil
			];
			[dictationButton setProperty:@"999" forKey:@"default"];
			[dictationButton setProperty:@"dictationButton" forKey:@"key"];
			[dictationButton setValues:@[ @"999", @"0" ] titles:@[ @"Default", @"Disable" ]];
			[dictationButton setProperty:kPackage forKey:@"defaults"];
			[dictationButton setProperty:kSettingsChanged forKey:@"PostNotification"];
			[dictationButton setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:dictationButton];
		}

		if (@available(iOS 11, *)) {
//		if (kIsiOS11AndUp) {
			PSSpecifier* shouldShowInternationalKeyGroup = [PSSpecifier groupSpecifierWithName:@"Globe Button"];
			[shouldShowInternationalKeyGroup setProperty:@"shouldShowInternationalKeyGroup" forKey:@"key"];
			[_specifiers addObject:shouldShowInternationalKeyGroup];

			PSSpecifier *shouldShowInternationalKey = [PSSpecifier preferenceSpecifierNamed:@"ShowInternationalKey"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSSegmentCell
				edit:nil
			];
			[shouldShowInternationalKey setProperty:@"999" forKey:@"default"];
			[shouldShowInternationalKey setProperty:@"shouldShowInternationalKey" forKey:@"key"];
			[shouldShowInternationalKey setValues:@[ @"999", @"0" ] titles:@[ @"Default", @"Disable" ]];
			[shouldShowInternationalKey setProperty:kPackage forKey:@"defaults"];
			[shouldShowInternationalKey setProperty:kSettingsChanged forKey:@"PostNotification"];
			[shouldShowInternationalKey setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:shouldShowInternationalKey];
		}

//		if (@available(iOS 8, *)) {
//		if (kIsiOS8AndUp) {
			PSSpecifier* returnKeyStylingGroup = [PSSpecifier groupSpecifierWithName:@"Return Key Styling"];
			[returnKeyStylingGroup setProperty:@"returnKeyStylingGroup" forKey:@"key"];
			[_specifiers addObject:returnKeyStylingGroup];

			PSSpecifier *returnKeyStyling = [PSSpecifier preferenceSpecifierNamed:@"returnKeyStyling"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSSegmentCell
				edit:nil
			];
			[returnKeyStyling setProperty:@"999" forKey:@"default"];
			[returnKeyStyling setProperty:@"returnKeyStyling" forKey:@"key"];
			[returnKeyStyling setValues:@[ @"999", @"0", @"1" ] titles:@[ @"Default", @"Disable", @"Enable" ]];
			[returnKeyStyling setProperty:kPackage forKey:@"defaults"];
			[returnKeyStyling setProperty:kSettingsChanged forKey:@"PostNotification"];
			[returnKeyStyling setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:returnKeyStyling];
//		}

		PSSpecifier* selectingSkinToneForEmojiGroup = [PSSpecifier groupSpecifierWithName:@"Selecting skin tone for emoji"];
		[selectingSkinToneForEmojiGroup setProperty:@"selectingSkinToneForEmojiGroup" forKey:@"key"];
		[_specifiers addObject:selectingSkinToneForEmojiGroup];

		PSSpecifier *selectingSkinToneForEmoji = [PSSpecifier preferenceSpecifierNamed:@"selectingSkinToneForEmoji"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSSegmentCell
			edit:nil
		];
		[selectingSkinToneForEmoji setProperty:@"999" forKey:@"default"];
		[selectingSkinToneForEmoji setProperty:@"selectingSkinToneForEmoji" forKey:@"key"];
		[selectingSkinToneForEmoji setValues:@[ @"999", @"1" ] titles:@[ @"Default", @"Disable" ]];
		[selectingSkinToneForEmoji setProperty:kPackage forKey:@"defaults"];
		[selectingSkinToneForEmoji setProperty:kSettingsChanged forKey:@"PostNotification"];
		[selectingSkinToneForEmoji setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:selectingSkinToneForEmoji];

		PSSpecifier* testKeyboardGroup = [PSSpecifier groupSpecifierWithName:@"Testing area"];
		[_specifiers addObject:testKeyboardGroup];

		PSTextFieldSpecifier *testKeyboard = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[testKeyboard setPlaceholder:@"Test keyboard here"];

		[_specifiers addObject:testKeyboard];
	}
	return _specifiers;
}
@end
