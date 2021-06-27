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
-(PSSpecifier *)createGroupSpecifierNamed:(NSString *)name key:(NSString *)key {
	PSSpecifier * specifier = [PSSpecifier groupSpecifierWithName:name];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	return specifier;
}
-(PSSpecifier *)createSegmentSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue {
	PSSpecifier * specifier = [PSSpecifier preferenceSpecifierNamed:name
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
	[specifier setProperty:kPackage forKey:@"defaults"];
	[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
	[specifier setProperty:@"55" forKey:@"height"];
	return specifier;
}
-(PSTextFieldSpecifier *)createEditTextSpecifierNamed:(NSString *)name key:(NSString *)key placeholder:(NSString *)placeholder {
	PSTextFieldSpecifier * specifier = [PSTextFieldSpecifier preferenceSpecifierNamed:name
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
	[specifier setPlaceholder:placeholder];
	return specifier;
}
- (NSArray *)specifiers {
	if ( !_specifiers ) {
		_specifiers = [NSMutableArray new];

		if (@available(iOS 11, *)) {
			PSSpecifier * oneHandedKeyboardGroup = [self createGroupSpecifierNamed:@"One-Handed Keyboard" key:@"oneHandedKeyboardGroup"];
			[_specifiers addObject:oneHandedKeyboardGroup];

			PSSpecifier * oneHandedKeyboard = [self createSegmentSpecifierNamed:@"oneHandedKeyboard" key:@"oneHandedKeyboard" default:@"999"];
			[oneHandedKeyboard setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Force Left", @"Force Right" ]];
			[_specifiers addObject:oneHandedKeyboard];
		}

		PSSpecifier * useBlueThemingForKeyGroup = [self createGroupSpecifierNamed:@"Blue Theming of Keyboard" key:@"useBlueThemingForKeyGroup"];
		[_specifiers addObject:useBlueThemingForKeyGroup];

		PSSpecifier * useBlueThemingForKey = [self createSegmentSpecifierNamed:@"useBlueThemingForKey" key:@"useBlueThemingForKey" default:@"999"];
		[useBlueThemingForKey setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Disable", @"Enable" ]];
		[_specifiers addObject:useBlueThemingForKey];

		PSSpecifier * testKeyboardGroup = [PSSpecifier groupSpecifierWithName:@"Testing area"];
		[_specifiers addObject:testKeyboardGroup];

		PSTextFieldSpecifier * testKeyboard = [self createEditTextSpecifierNamed:@"" key:@"testKeyboard" placeholder:@"Test keyboard here"];
		[_specifiers addObject:testKeyboard];
	}
	return _specifiers;
}
@end
