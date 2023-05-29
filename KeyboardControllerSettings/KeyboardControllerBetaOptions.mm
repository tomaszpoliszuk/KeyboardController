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

@implementation KeyboardControllerBetaOptions
- (PSSpecifier *)createGroupSpecifierNamed:(NSString *)name key:(NSString *)key {
	PSSpecifier *specifier = [PSSpecifier groupSpecifierWithName:name];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	return specifier;
}
//	- (PSSpecifier *)createGroupSpecifierNamed:(NSString *)name footer:(NSString *)footer key:(NSString *)key {
//		PSSpecifier *specifier = [PSSpecifier groupSpecifierWithHeader:name footer:footer];
//		[specifier setProperty:name forKey:@"label"];
//		[specifier setProperty:key forKey:@"key"];
//		[specifier setProperty:key forKey:@"id"];
//		return specifier;
//	}
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
//	- (PSSpecifier *)createLinkListSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue detail:(NSString *)detail {
//		PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:name
//			target:self
//			set:@selector(setPreferenceValue:specifier:)
//			get:@selector(readPreferenceValue:)
//			detail:NSClassFromString(detail)
//			cell:PSLinkListCell
//			edit:nil
//		];
//		[specifier setProperty:name forKey:@"label"];
//		[specifier setProperty:key forKey:@"key"];
//		[specifier setProperty:key forKey:@"id"];
//		[specifier setProperty:defaultValue forKey:@"default"];
//		[specifier setProperty:@kPackageName forKey:@"defaults"];
//		[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
//		return specifier;
//	}
- (PSTextFieldSpecifier *)createEditTextSpecifierNamed:(NSString *)name key:(NSString *)key placeholder:(NSString *)placeholder {
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
	[specifier setPlaceholder:placeholder];
	return specifier;
}
- (NSArray *)specifiers {
	if ( !_specifiers ) {
		_specifiers = [NSMutableArray new];

//		if (@available(iOS 13, *)) {
//			if ( [[UIDevice currentDevice] respondsToSelector:@selector(_tapticEngine)] ) {
//			if ( [[UIDevice currentDevice] respondsToSelector:@selector(_feedbackSupportLevel)] ) {
//				[[UIDevice currentDevice] valueForKey:@"_feedbackSupportLevel"];
//				if ( [UIDevice currentDevice]._tapticEngine ) {
//				if ( [UIDevice currentDevice]._feedbackSupportLevel != 0 ) {
//					PSSpecifier *feedbackGroup = [self createGroupSpecifierNamed:@"Haptic Feedback" footer:nil key:@"feedbackGroup"];
//					[_specifiers addObject:feedbackGroup];
//
//					NSArray *feedbackTypeTitles = @[ @"Disabled", @"selection", @"Light", @"Medium", @"Heavy", @"Soft", @"Rigid" ];
//					NSArray *feedbackTypeValues = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6" ];
//
//					if ( [UIDevice currentDevice]._feedbackSupportLevel == 1 ) {
//						feedbackTypeTitles = @[ @"Disabled", @"Light", @"Heavy" ];
//						feedbackTypeValues = @[ @"0", @"1519", @"1520" ];
//					}
//					if ( [UIDevice currentDevice]._feedbackSupportLevel == 2 ) {
//					}
//
//					PSSpecifier *feedbackType = [self createLinkListSpecifierNamed:@"Haptic type:" key:@"feedbackType" default:@"0" detail:@"PSListItemsController"];
//					[feedbackType setValues:feedbackTypeValues titles:feedbackTypeTitles];
//					[_specifiers addObject:feedbackType];
//
//					NSArray *feedbackWhenTitles = @[ @"start", @"end" ];
//					NSArray *feedbackWhenValues = @[ @"0", @"1" ];
//
//					PSSpecifier *feedbackWhen = [self createLinkListSpecifierNamed:@"Select feedback type:" key:@"feedbackWhen" default:@"0" detail:@"PSListItemsController"];
//					[feedbackWhen setValues:feedbackWhenValues titles:feedbackWhenTitles];
//					[_specifiers addObject:feedbackWhen];
//				}
//			}
//		}

		if (@available(iOS 11, *)) {
			PSSpecifier *oneHandedKeyboardGroup = [self createGroupSpecifierNamed:@"One-Handed Keyboard" key:@"oneHandedKeyboardGroup"];
			[_specifiers addObject:oneHandedKeyboardGroup];

			PSSpecifier *oneHandedKeyboard = [self createSegmentSpecifierNamed:@"oneHandedKeyboard" key:@"oneHandedKeyboard" default:@"999"];
			[oneHandedKeyboard setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Force Left", @"Force Right" ]];
			[_specifiers addObject:oneHandedKeyboard];
		}

		PSSpecifier *useBlueThemingForKeyGroup = [self createGroupSpecifierNamed:@"Blue Theming of Keyboard" key:@"useBlueThemingForKeyGroup"];
		[_specifiers addObject:useBlueThemingForKeyGroup];

		PSSpecifier *useBlueThemingForKey = [self createSegmentSpecifierNamed:@"useBlueThemingForKey" key:@"useBlueThemingForKey" default:@"999"];
		[useBlueThemingForKey setValues:@[ @"999", @"2", @"1" ] titles:@[ @"Default", @"Disable", @"Enable" ]];
		[_specifiers addObject:useBlueThemingForKey];

		PSSpecifier *testKeyboardGroup = [PSSpecifier groupSpecifierWithName:@"Testing area"];
		[_specifiers addObject:testKeyboardGroup];

		PSTextFieldSpecifier *testKeyboard = [self createEditTextSpecifierNamed:@"" key:@"testKeyboard" placeholder:@"Test keyboard here"];
		[_specifiers addObject:testKeyboard];
	}
	return _specifiers;
}
@end
