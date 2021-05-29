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

@implementation KeyboardControllerReturnKeyTypeSettings
- (NSArray *)specifiers {
	if ( !_specifiers ) {
		_specifiers = [self loadSpecifiersFromPlistName:@"ReturnKeyType" target:self];

		NSArray *values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11" ];
		NSArray *titles = @[ @"Default", @"Go", @"Google", @"Join", @"Next", @"Route", @"Search", @"Send", @"Yahoo", @"Done", @"Emergency Call", @"Continue" ];
		if ( !kIsiOS9AndUp ) {
			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10" ];
			titles = @[ @"Default", @"Go", @"Google", @"Join", @"Next", @"Route", @"Search", @"Send", @"Yahoo", @"Done", @"Emergency Call" ];
		}

		PSSpecifier* emptyGroup = [PSSpecifier emptyGroupSpecifier];

		PSSpecifier *returnKeyTypeDefault = [PSSpecifier preferenceSpecifierNamed:@"Default"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeDefault setProperty:@"0" forKey:@"default"];
		[returnKeyTypeDefault setProperty:@"returnKeyTypeDefault" forKey:@"key"];
		[returnKeyTypeDefault setValues:values titles:titles];
		[returnKeyTypeDefault setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeDefault setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeDefault setProperty:@"55" forKey:@"height"];


		PSSpecifier *returnKeyTypeGo = [PSSpecifier preferenceSpecifierNamed:@"Go"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeGo setProperty:@"1" forKey:@"default"];
		[returnKeyTypeGo setProperty:@"returnKeyTypeGo" forKey:@"key"];
		[returnKeyTypeGo setValues:values titles:titles];
		[returnKeyTypeGo setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeGo setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeGo setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeGoogle = [PSSpecifier preferenceSpecifierNamed:@"Google"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeGoogle setProperty:@"2" forKey:@"default"];
		[returnKeyTypeGoogle setProperty:@"returnKeyTypeGoogle" forKey:@"key"];
		[returnKeyTypeGoogle setValues:values titles:titles];
		[returnKeyTypeGoogle setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeGoogle setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeGoogle setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeJoin = [PSSpecifier preferenceSpecifierNamed:@"Join"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeJoin setProperty:@"3" forKey:@"default"];
		[returnKeyTypeJoin setProperty:@"returnKeyTypeJoin" forKey:@"key"];
		[returnKeyTypeJoin setValues:values titles:titles];
		[returnKeyTypeJoin setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeJoin setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeJoin setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeNext = [PSSpecifier preferenceSpecifierNamed:@"Next"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeNext setProperty:@"4" forKey:@"default"];
		[returnKeyTypeNext setProperty:@"returnKeyTypeNext" forKey:@"key"];
		[returnKeyTypeNext setValues:values titles:titles];
		[returnKeyTypeNext setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeNext setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeNext setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeRoute = [PSSpecifier preferenceSpecifierNamed:@"Route"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeRoute setProperty:@"5" forKey:@"default"];
		[returnKeyTypeRoute setProperty:@"returnKeyTypeRoute" forKey:@"key"];
		[returnKeyTypeRoute setValues:values titles:titles];
		[returnKeyTypeRoute setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeRoute setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeRoute setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeSearch = [PSSpecifier preferenceSpecifierNamed:@"Search"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeSearch setProperty:@"6" forKey:@"default"];
		[returnKeyTypeSearch setProperty:@"returnKeyTypeSearch" forKey:@"key"];
		[returnKeyTypeSearch setValues:values titles:titles];
		[returnKeyTypeSearch setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeSearch setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeSearch setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeSend = [PSSpecifier preferenceSpecifierNamed:@"Send"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeSend setProperty:@"7" forKey:@"default"];
		[returnKeyTypeSend setProperty:@"returnKeyTypeSend" forKey:@"key"];
		[returnKeyTypeSend setValues:values titles:titles];
		[returnKeyTypeSend setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeSend setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeSend setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeYahoo = [PSSpecifier preferenceSpecifierNamed:@"Yahoo"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeYahoo setProperty:@"8" forKey:@"default"];
		[returnKeyTypeYahoo setProperty:@"returnKeyTypeYahoo" forKey:@"key"];
		[returnKeyTypeYahoo setValues:values titles:titles];
		[returnKeyTypeYahoo setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeYahoo setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeYahoo setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeDone = [PSSpecifier preferenceSpecifierNamed:@"Done"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeDone setProperty:@"9" forKey:@"default"];
		[returnKeyTypeDone setProperty:@"returnKeyTypeDone" forKey:@"key"];
		[returnKeyTypeDone setValues:values titles:titles];
		[returnKeyTypeDone setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeDone setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeDone setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeEmergencyCall = [PSSpecifier preferenceSpecifierNamed:@"Emergency Call"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeEmergencyCall setProperty:@"10" forKey:@"default"];
		[returnKeyTypeEmergencyCall setProperty:@"returnKeyTypeEmergencyCall" forKey:@"key"];
		[returnKeyTypeEmergencyCall setValues:values titles:titles];
		[returnKeyTypeEmergencyCall setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeEmergencyCall setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeEmergencyCall setProperty:@"55" forKey:@"height"];

		PSSpecifier *returnKeyTypeContinue = [PSSpecifier preferenceSpecifierNamed:@"Continue"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];

		[returnKeyTypeContinue setProperty:@"11" forKey:@"default"];
		[returnKeyTypeContinue setProperty:@"returnKeyTypeContinue" forKey:@"key"];
		[returnKeyTypeContinue setValues:values titles:titles];
		[returnKeyTypeContinue setProperty:kPackage forKey:@"defaults"];
		[returnKeyTypeContinue setProperty:kSettingsChanged forKey:@"PostNotification"];
		[returnKeyTypeContinue setProperty:@"55" forKey:@"height"];



		PSSpecifier* testKeyboardGroup = [PSSpecifier groupSpecifierWithName:@"Testing area"];

		PSTextFieldSpecifier *testKeyboard = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[testKeyboard setPlaceholder:@"Test keyboard here"];

		_specifiers = [NSMutableArray new];

		[_specifiers addObject:emptyGroup];
		[_specifiers addObject:returnKeyTypeDefault];
		[_specifiers addObject:returnKeyTypeGo];
		[_specifiers addObject:returnKeyTypeGoogle];
		[_specifiers addObject:returnKeyTypeJoin];
		[_specifiers addObject:returnKeyTypeNext];
		[_specifiers addObject:returnKeyTypeRoute];
		[_specifiers addObject:returnKeyTypeSearch];
		[_specifiers addObject:returnKeyTypeSend];
		[_specifiers addObject:returnKeyTypeYahoo];
		[_specifiers addObject:returnKeyTypeDone];
		[_specifiers addObject:returnKeyTypeEmergencyCall];
		if ( kIsiOS9AndUp ) {
			[_specifiers addObject:returnKeyTypeContinue];
		}
		[_specifiers addObject:testKeyboardGroup];
		[_specifiers addObject:testKeyboard];
	}
	return _specifiers;
}
@end
