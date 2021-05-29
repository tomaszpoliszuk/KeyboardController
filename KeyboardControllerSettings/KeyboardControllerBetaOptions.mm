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

@implementation KeyboardControllerBetaOptions
- (NSArray *)specifiers {
	if ( !_specifiers ) {

		_specifiers = [NSMutableArray new];

		if (@available(iOS 11, *)) {

			PSSpecifier* oneHandedKeyboardGroup = [PSSpecifier groupSpecifierWithName:@"One-Handed Keyboard"];
			[oneHandedKeyboardGroup setProperty:@"oneHandedKeyboardGroup" forKey:@"key"];
			[_specifiers addObject:oneHandedKeyboardGroup];

			PSSpecifier *oneHandedKeyboard = [PSSpecifier preferenceSpecifierNamed:@"oneHandedKeyboard"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSSegmentCell
				edit:nil
			];
			[oneHandedKeyboard setProperty:@"999" forKey:@"default"];
			[oneHandedKeyboard setProperty:@"oneHandedKeyboard" forKey:@"key"];
			[oneHandedKeyboard setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Force Left", @"Force Right" ]];
			[oneHandedKeyboard setProperty:kPackage forKey:@"defaults"];
			[oneHandedKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
			[oneHandedKeyboard setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:oneHandedKeyboard];
		}

		PSSpecifier* useBlueThemingForKeyGroup = [PSSpecifier groupSpecifierWithName:@"Blue Theming of Keyboard"];
		[useBlueThemingForKeyGroup setProperty:@"useBlueThemingForKeyGroup" forKey:@"key"];
		[_specifiers addObject:useBlueThemingForKeyGroup];

		PSSpecifier *useBlueThemingForKey = [PSSpecifier preferenceSpecifierNamed:@"useBlueThemingForKey"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSSegmentCell
			edit:nil
		];
		[useBlueThemingForKey setProperty:@"999" forKey:@"default"];
		[useBlueThemingForKey setProperty:@"useBlueThemingForKey" forKey:@"key"];
		[useBlueThemingForKey setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Disable", @"Enable" ]];
		[useBlueThemingForKey setProperty:kPackage forKey:@"defaults"];
		[useBlueThemingForKey setProperty:kSettingsChanged forKey:@"PostNotification"];
		[useBlueThemingForKey setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:useBlueThemingForKey];

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
