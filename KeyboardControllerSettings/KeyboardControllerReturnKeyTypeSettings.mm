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

@implementation KeyboardControllerReturnKeyTypeSettings
- (PSSpecifier *)createLinkListSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue {
	PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:name
		target:self
		set:@selector(setPreferenceValue:specifier:)
		get:@selector(readPreferenceValue:)
		detail:NSClassFromString(@"PSListItemsController")
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
- (NSArray *)specifiers {
	if ( !_specifiers ) {
		_specifiers = [NSMutableArray new];

		NSArray *values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10" ];
		NSArray *titles = @[ @"Default", @"Go", @"Google", @"Join", @"Next", @"Route", @"Search", @"Send", @"Yahoo", @"Done", @"Emergency Call" ];

		if (@available(iOS 9, *)) {
			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11" ];
			titles = @[ @"Default", @"Go", @"Google", @"Join", @"Next", @"Route", @"Search", @"Send", @"Yahoo", @"Done", @"Emergency Call", @"Continue" ];
		}

		PSSpecifier *emptyGroup = [PSSpecifier emptyGroupSpecifier];
		[_specifiers addObject:emptyGroup];

		PSSpecifier *returnKeyTypeDefault = [self createLinkListSpecifierNamed:@"Default" key:@"returnKeyTypeDefault" default:@"0"];
		[returnKeyTypeDefault setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeDefault];

		PSSpecifier *returnKeyTypeGo = [self createLinkListSpecifierNamed:@"Go" key:@"returnKeyTypeGo" default:@"1"];
		[returnKeyTypeGo setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeGo];

		PSSpecifier *returnKeyTypeGoogle = [self createLinkListSpecifierNamed:@"Google" key:@"returnKeyTypeGoogle" default:@"2"];
		[returnKeyTypeGoogle setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeGoogle];

		PSSpecifier *returnKeyTypeJoin = [self createLinkListSpecifierNamed:@"Join" key:@"returnKeyTypeJoin" default:@"3"];
		[returnKeyTypeJoin setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeJoin];

		PSSpecifier *returnKeyTypeNext = [self createLinkListSpecifierNamed:@"Next" key:@"returnKeyTypeNext" default:@"4"];
		[returnKeyTypeNext setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeNext];

		PSSpecifier *returnKeyTypeRoute = [self createLinkListSpecifierNamed:@"Route" key:@"returnKeyTypeRoute" default:@"5"];
		[returnKeyTypeRoute setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeRoute];

		PSSpecifier *returnKeyTypeSearch = [self createLinkListSpecifierNamed:@"Search" key:@"returnKeyTypeSearch" default:@"6"];
		[returnKeyTypeSearch setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeSearch];

		PSSpecifier *returnKeyTypeSend = [self createLinkListSpecifierNamed:@"Send" key:@"returnKeyTypeSend" default:@"7"];
		[returnKeyTypeSend setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeSend];

		PSSpecifier *returnKeyTypeYahoo = [self createLinkListSpecifierNamed:@"Yahoo" key:@"returnKeyTypeYahoo" default:@"8"];
		[returnKeyTypeYahoo setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeYahoo];

		PSSpecifier *returnKeyTypeDone = [self createLinkListSpecifierNamed:@"Done" key:@"returnKeyTypeDone" default:@"9"];
		[returnKeyTypeDone setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeDone];

		PSSpecifier *returnKeyTypeEmergencyCall = [self createLinkListSpecifierNamed:@"Emergency Call" key:@"returnKeyTypeEmergencyCall" default:@"10"];
		[returnKeyTypeEmergencyCall setValues:values titles:titles];
		[_specifiers addObject:returnKeyTypeEmergencyCall];

		if (@available(iOS 9, *)) {
			PSSpecifier *returnKeyTypeContinue = [self createLinkListSpecifierNamed:@"Continue" key:@"returnKeyTypeContinue" default:@"11"];
			[returnKeyTypeContinue setValues:values titles:titles];
			[_specifiers addObject:returnKeyTypeContinue];
		}
	}
	return _specifiers;
}
@end
