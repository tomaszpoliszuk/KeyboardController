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

		if (@available(iOS 10, *)) {
			PSSpecifier * dictationButtonGroup = [self createGroupSpecifierNamed:@"Dictation Button" key:@"dictationButtonGroup"];
			[_specifiers addObject:dictationButtonGroup];

			PSSpecifier * dictationButton = [self createSegmentSpecifierNamed:@"dictationButton" key:@"dictationButton" default:@"999"];
			[dictationButton setValues:@[ @"999", @"0" ] titles:@[ @"Default", @"Disable" ]];
			[_specifiers addObject:dictationButton];
		}

		if (@available(iOS 11, *)) {
			PSSpecifier * shouldShowInternationalKeyGroup = [self createGroupSpecifierNamed:@"Globe Button" key:@"shouldShowInternationalKeyGroup"];
			[_specifiers addObject:shouldShowInternationalKeyGroup];

			PSSpecifier * shouldShowInternationalKey = [self createSegmentSpecifierNamed:@"shouldShowInternationalKey" key:@"shouldShowInternationalKey" default:@"999"];
			[shouldShowInternationalKey setValues:@[ @"999", @"0" ] titles:@[ @"Default", @"Disable" ]];
			[_specifiers addObject:shouldShowInternationalKey];
		}

//		if (@available(iOS 8, *)) {
			PSSpecifier * returnKeyStylingGroup = [self createGroupSpecifierNamed:@"Return Key Styling" key:@"returnKeyStylingGroup"];
			[_specifiers addObject:returnKeyStylingGroup];

			PSSpecifier * returnKeyStyling = [self createSegmentSpecifierNamed:@"returnKeyStyling" key:@"returnKeyStyling" default:@"999"];
			[returnKeyStyling setValues:@[ @"999", @"0", @"1" ] titles:@[ @"Default", @"Disable", @"Enable" ]];
			[_specifiers addObject:returnKeyStyling];
//		}

		PSSpecifier * selectingSkinToneForEmojiGroup = [self createGroupSpecifierNamed:@"Selecting skin tone for emoji" key:@"selectingSkinToneForEmojiGroup"];
		[_specifiers addObject:selectingSkinToneForEmojiGroup];

		PSSpecifier * selectingSkinToneForEmoji = [self createSegmentSpecifierNamed:@"selectingSkinToneForEmoji" key:@"selectingSkinToneForEmoji" default:@"999"];
		[selectingSkinToneForEmoji setValues:@[ @"999", @"1" ] titles:@[ @"Default", @"Disable" ]];
		[_specifiers addObject:selectingSkinToneForEmoji];

		PSSpecifier * testKeyboardGroup = [PSSpecifier groupSpecifierWithName:@"Testing area"];
		[_specifiers addObject:testKeyboardGroup];

		PSTextFieldSpecifier * testKeyboard = [self createEditTextSpecifierNamed:@"" key:@"testKeyboard" placeholder:@"Test keyboard here"];
		[_specifiers addObject:testKeyboard];
	}
	return _specifiers;
}
@end
