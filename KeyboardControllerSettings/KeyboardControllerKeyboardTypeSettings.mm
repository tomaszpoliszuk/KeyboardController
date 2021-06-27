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

@implementation KeyboardControllerKeyboardTypeSettings
-(PSSpecifier *)createGroupSpecifierNamed:(NSString *)name footer:(NSString *)footer key:(NSString *)key {
	PSSpecifier * specifier = [PSSpecifier groupSpecifierWithHeader:name footer:footer];
	[specifier setProperty:name forKey:@"label"];
	[specifier setProperty:key forKey:@"key"];
	[specifier setProperty:key forKey:@"id"];
	return specifier;
}
-(PSSpecifier *)createLinkListSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue {
	PSSpecifier * specifier = [PSSpecifier preferenceSpecifierNamed:name
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
	[specifier setProperty:kPackage forKey:@"defaults"];
	[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
	return specifier;
}
-(PSTextFieldSpecifier *)createEditTextSpecifierNamed:(NSString *)name key:(NSString *)key default:(NSString *)defaultValue {
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
	[specifier setProperty:defaultValue forKey:@"default"];
	[specifier setProperty:kPackage forKey:@"defaults"];
	[specifier setProperty:kSettingsChanged forKey:@"PostNotification"];
	return specifier;
}
- (NSArray *)specifiers {
	if ( !_specifiers ) {
		_specifiers = [NSMutableArray new];

		NSArray * titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search" ];
		NSArray * values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10" ];

//		if (@available(iOS 4.1, *)) {
//			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address" ];
//			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7" ];
//		}
//		if (@available(iOS 5, *)) {
//			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad" ];
//			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8" ];
//		}
//		if (@available(iOS 7, *)) {
//			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter" ];
//			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9" ];
//		}

		if (@available(iOS 10, *)) {
			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search", @"ASCII Capable Number Pad" ];
			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11" ];
		}

		PSSpecifier * defaultKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies the default keyboard for the current input method." key:@"defaultKeyboardGroup"];
		[_specifiers addObject:defaultKeyboardGroup];

		PSSpecifier * defaultKeyboard = [self createLinkListSpecifierNamed:@"Default" key:@"defaultKeyboard" default:@"0"];
		[defaultKeyboard setValues:values titles:titles];
		[_specifiers addObject:defaultKeyboard];

		PSTextFieldSpecifier * defaultKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"defaultKeyboardTry" default:nil];
		[defaultKeyboardTry setKeyboardType:0 autoCaps:NO autoCorrection:NO];
		[defaultKeyboardTry setPlaceholder:@"Test Default keyboard"];
		[_specifiers addObject:defaultKeyboardTry];

		PSSpecifier * asciiCapableKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keyboard that displays standard ASCII characters." key:@"asciiCapableKeyboardGroup"];
		[_specifiers addObject:asciiCapableKeyboardGroup];

		PSSpecifier * asciiCapableKeyboard = [self createLinkListSpecifierNamed:@"ASCII Capable" key:@"asciiCapableKeyboard" default:@"1"];
		[asciiCapableKeyboard setValues:values titles:titles];
		[_specifiers addObject:asciiCapableKeyboard];

		PSTextFieldSpecifier * asciiCapableKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"asciiCapableKeyboardTry" default:nil];
		[asciiCapableKeyboardTry setKeyboardType:1 autoCaps:NO autoCorrection:NO];
		[asciiCapableKeyboardTry setPlaceholder:@"Test ASCII Capable keyboard"];
		[_specifiers addObject:asciiCapableKeyboardTry];

		PSSpecifier * numbersAndPunctuationKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies the numbers and punctuation keyboard." key:@"numbersAndPunctuationKeyboardGroup"];
		[_specifiers addObject:numbersAndPunctuationKeyboardGroup];

		PSSpecifier * numbersAndPunctuationKeyboard = [self createLinkListSpecifierNamed:@"Numbers and Punctuation" key:@"numbersAndPunctuationKeyboard" default:@"2"];
		[numbersAndPunctuationKeyboard setValues:values titles:titles];
		[_specifiers addObject:numbersAndPunctuationKeyboard];

		PSTextFieldSpecifier * numbersAndPunctuationKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"numbersAndPunctuationKeyboardTry" default:nil];
		[numbersAndPunctuationKeyboardTry setKeyboardType:2 autoCaps:NO autoCorrection:NO];
		[numbersAndPunctuationKeyboardTry setPlaceholder:@"Test Numbers and Punctuation keyboard"];
		[_specifiers addObject:numbersAndPunctuationKeyboardTry];

		PSSpecifier * urlKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keyboard optimized for URL entry. This keyboard type prominently features the period (“.”) and slash (“/”) characters and the “.com” string." key:@"urlKeyboardGroup"];
		[_specifiers addObject:urlKeyboardGroup];

		PSSpecifier * urlKeyboard = [self createLinkListSpecifierNamed:@"URL" key:@"urlKeyboard" default:@"3"];
		[urlKeyboard setValues:values titles:titles];
		[_specifiers addObject:urlKeyboard];

		PSTextFieldSpecifier * urlKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"urlKeyboardTry" default:nil];
		[urlKeyboardTry setKeyboardType:3 autoCaps:NO autoCorrection:NO];
		[urlKeyboardTry setPlaceholder:@"Test URL keyboard"];
		[_specifiers addObject:urlKeyboardTry];

		PSSpecifier * numberPadKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a numeric keypad designed for PIN entry. This keyboard type prominently features the numbers 0 through 9. This keyboard type does not support auto-capitalization." key:@"numberPadKeyboardGroup"];
		[_specifiers addObject:numberPadKeyboardGroup];

		PSSpecifier * numberPadKeyboard = [self createLinkListSpecifierNamed:@"Number Pad keyboard" key:@"numberPadKeyboard" default:@"4"];
		[numberPadKeyboard setValues:values titles:titles];
		[_specifiers addObject:numberPadKeyboard];

		PSTextFieldSpecifier * numberPadKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"numberPadKeyboardTry" default:nil];
		[numberPadKeyboardTry setKeyboardType:4 autoCaps:NO autoCorrection:NO];
		[numberPadKeyboardTry setPlaceholder:@"Test Number Pad keyboard"];
		[_specifiers addObject:numberPadKeyboardTry];

		PSSpecifier * phonePadKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keypad designed for entering telephone numbers. This keyboard type prominently features the numbers 0 through 9 and the “*” and “#” characters. This keyboard type does not support auto-capitalization." key:@"phonePadKeyboardGroup"];
		[_specifiers addObject:phonePadKeyboardGroup];

		PSSpecifier * phonePadKeyboard = [self createLinkListSpecifierNamed:@"Phone Pad keyboard" key:@"phonePadKeyboard" default:@"5"];
		[phonePadKeyboard setValues:values titles:titles];
		[_specifiers addObject:phonePadKeyboard];

		PSTextFieldSpecifier * phonePadKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"phonePadKeyboardTry" default:nil];
		[phonePadKeyboardTry setKeyboardType:5 autoCaps:NO autoCorrection:NO];
		[phonePadKeyboardTry setPlaceholder:@"Test Phone Pad keyboard"];
		[_specifiers addObject:phonePadKeyboardTry];

		PSSpecifier * namePhonePadKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keyboard optimized for alphabetic entry." key:@"namePhonePadKeyboardGroup"];
		[_specifiers addObject:namePhonePadKeyboardGroup];

		PSSpecifier * namePhonePadKeyboard = [self createLinkListSpecifierNamed:@"Name Phone Pad keyboard" key:@"namePhonePadKeyboard" default:@"6"];
		[namePhonePadKeyboard setValues:values titles:titles];
		[_specifiers addObject:namePhonePadKeyboard];

		PSTextFieldSpecifier * namePhonePadKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"namePhonePadKeyboardTry" default:nil];
		[namePhonePadKeyboardTry setKeyboardType:6 autoCaps:NO autoCorrection:NO];
		[namePhonePadKeyboardTry setPlaceholder:@"Test Name Phone Pad keyboard"];
		[_specifiers addObject:namePhonePadKeyboardTry];

		PSSpecifier * emailAddressKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keyboard optimized for entering email addresses. This keyboard type prominently features the at (“@”), period (“.”) and space characters." key:@"emailAddressKeyboardGroup"];
		[_specifiers addObject:emailAddressKeyboardGroup];

		PSSpecifier * emailAddressKeyboard = [self createLinkListSpecifierNamed:@"Email Address" key:@"emailAddressKeyboard" default:@"7"];
		[emailAddressKeyboard setValues:values titles:titles];
		[_specifiers addObject:emailAddressKeyboard];

		PSTextFieldSpecifier * emailAddressKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"emailAddressKeyboardTry" default:nil];
		[emailAddressKeyboardTry setKeyboardType:7 autoCaps:NO autoCorrection:NO];
		[emailAddressKeyboardTry setPlaceholder:@"Test Email Address keyboard"];
		[_specifiers addObject:emailAddressKeyboardTry];

//		if (@available(iOS 4.1, *)) {
			PSSpecifier * decimalPadKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keyboard with numbers and a decimal point." key:@"decimalPadKeyboardGroup"];
			[_specifiers addObject:decimalPadKeyboardGroup];

			PSSpecifier * decimalPadKeyboard = [self createLinkListSpecifierNamed:@"Decimal Pad keyboard" key:@"decimalPadKeyboard" default:@"8"];
			[decimalPadKeyboard setValues:values titles:titles];
			[_specifiers addObject:decimalPadKeyboard];

			PSTextFieldSpecifier * decimalPadKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"decimalPadKeyboardTry" default:nil];
			[decimalPadKeyboardTry setKeyboardType:8 autoCaps:NO autoCorrection:NO];
			[decimalPadKeyboardTry setPlaceholder:@"Test Decimal Pad keyboard"];
			[_specifiers addObject:decimalPadKeyboardTry];
//		}

//		if (@available(iOS 5, *)) {
			PSSpecifier * twitterKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keyboard optimized for Twitter text entry, with easy access to the at (“@”) and hash (“#”) characters." key:@"twitterKeyboardGroup"];
			[_specifiers addObject:twitterKeyboardGroup];

			PSSpecifier * twitterKeyboard = [self createLinkListSpecifierNamed:@"Twitter keyboard" key:@"twitterKeyboard" default:@"9"];
			[twitterKeyboard setValues:values titles:titles];
			[_specifiers addObject:twitterKeyboard];

			PSTextFieldSpecifier * twitterKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"twitterKeyboardTry" default:nil];
			[twitterKeyboardTry setKeyboardType:9 autoCaps:NO autoCorrection:NO];
			[twitterKeyboardTry setPlaceholder:@"Test Twitter keyboard"];
			[_specifiers addObject:twitterKeyboardTry];
//		}

//		if (@available(iOS 7, *)) {
			PSSpecifier * webSearchKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a keyboard optimized for web search terms and URL entry. This keyboard type prominently features the space and period (“.”) characters." key:@"webSearchKeyboardGroup"];
			[_specifiers addObject:webSearchKeyboardGroup];

			PSSpecifier * webSearchKeyboard = [self createLinkListSpecifierNamed:@"Web Search keyboard" key:@"webSearchKeyboard" default:@"10"];
			[webSearchKeyboard setValues:values titles:titles];
			[_specifiers addObject:webSearchKeyboard];

			PSTextFieldSpecifier * webSearchKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"webSearchKeyboardTry" default:nil];
			[webSearchKeyboardTry setKeyboardType:10 autoCaps:NO autoCorrection:NO];
			[webSearchKeyboardTry setPlaceholder:@"Test Web Search keyboard"];
			[_specifiers addObject:webSearchKeyboardTry];
//		}

		if (@available(iOS 10, *)) {
			PSSpecifier * asciiCapableNumberPadKeyboardGroup = [self createGroupSpecifierNamed:@"" footer:@"Specifies a number pad that outputs only ASCII digits." key:@"asciiCapableNumberPadKeyboardGroup"];
			[_specifiers addObject:asciiCapableNumberPadKeyboardGroup];

			PSSpecifier * asciiCapableNumberPadKeyboard = [self createLinkListSpecifierNamed:@"ASCII Capable Number Pad keyboard" key:@"asciiCapableNumberPadKeyboard" default:@"11"];
			[asciiCapableNumberPadKeyboard setValues:values titles:titles];
			[_specifiers addObject:asciiCapableNumberPadKeyboard];

			PSTextFieldSpecifier * asciiCapableNumberPadKeyboardTry = [self createEditTextSpecifierNamed:@"" key:@"asciiCapableNumberPadKeyboardTry" default:nil];
			[asciiCapableNumberPadKeyboardTry setKeyboardType:11 autoCaps:NO autoCorrection:NO];
			[asciiCapableNumberPadKeyboardTry setPlaceholder:@"Test ASCII Capable Number Pad keyboard"];
			[_specifiers addObject:asciiCapableNumberPadKeyboardTry];
		}
	}
	return _specifiers;
}
@end
