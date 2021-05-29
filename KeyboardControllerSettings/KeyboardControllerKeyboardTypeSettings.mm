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
- (NSArray *)specifiers {

	if ( !_specifiers ) {

		_specifiers = [NSMutableArray new];

		NSArray *titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search", @"ASCII Capable Number Pad" ];
		NSArray *values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11" ];

		if ( !kIsiOS10AndUp ) {
			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter", @"Web Search" ];
			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10" ];
		}
//		if ( !kIsiOS7AndUp ) {
//			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad", @"Twitter" ];
//			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9" ];
//		}
//		if ( !kIsiOS5AndUp ) {
//			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address", @"Decimal Pad" ];
//			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8" ];
//		}
//		if ( !kIsiOS4_1AndUp ) {
//			titles = @[ @"Default", @"ASCII Capable", @"Numbers and Punctuation", @"URL", @"Number Pad", @"Phone Pad", @"Name Phone Pad", @"Email Address" ];
//			values = @[ @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7" ];
//		}

		PSSpecifier* defaultKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies the default keyboard for the current input method."];
		[defaultKeyboardGroup setProperty:@"defaultKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:defaultKeyboardGroup];

		PSSpecifier *defaultKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Default"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[defaultKeyboard setProperty:@"0" forKey:@"default"];
		[defaultKeyboard setProperty:@"defaultKeyboard" forKey:@"key"];
		[defaultKeyboard setValues:values titles:titles];
		[defaultKeyboard setProperty:kPackage forKey:@"defaults"];
		[defaultKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[defaultKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:defaultKeyboard];

		PSTextFieldSpecifier *defaultKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[defaultKeyboardTry setKeyboardType:0 autoCaps:NO autoCorrection:NO];
		[defaultKeyboardTry setPlaceholder:@"Test Default keyboard"];
		[_specifiers addObject:defaultKeyboardTry];

		PSSpecifier* asciiCapableKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keyboard that displays standard ASCII characters."];
		[asciiCapableKeyboardGroup setProperty:@"asciiCapableKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:asciiCapableKeyboardGroup];

		PSSpecifier *asciiCapableKeyboard = [PSSpecifier preferenceSpecifierNamed:@"ASCII Capable"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[asciiCapableKeyboard setProperty:@"1" forKey:@"default"];
		[asciiCapableKeyboard setProperty:@"asciiCapableKeyboard" forKey:@"key"];
		[asciiCapableKeyboard setValues:values titles:titles];
		[asciiCapableKeyboard setProperty:kPackage forKey:@"defaults"];
		[asciiCapableKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[asciiCapableKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:asciiCapableKeyboard];

		PSTextFieldSpecifier *asciiCapableKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[asciiCapableKeyboardTry setKeyboardType:1 autoCaps:NO autoCorrection:NO];
		[asciiCapableKeyboardTry setPlaceholder:@"Test ASCII Capable keyboard"];
		[_specifiers addObject:asciiCapableKeyboardTry];

		PSSpecifier* numbersAndPunctuationKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies the numbers and punctuation keyboard."];
		[numbersAndPunctuationKeyboardGroup setProperty:@"numbersAndPunctuationKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:numbersAndPunctuationKeyboardGroup];

		PSSpecifier *numbersAndPunctuationKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Numbers and Punctuation"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[numbersAndPunctuationKeyboard setProperty:@"2" forKey:@"default"];
		[numbersAndPunctuationKeyboard setProperty:@"numbersAndPunctuationKeyboard" forKey:@"key"];
		[numbersAndPunctuationKeyboard setValues:values titles:titles];
		[numbersAndPunctuationKeyboard setProperty:kPackage forKey:@"defaults"];
		[numbersAndPunctuationKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[numbersAndPunctuationKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:numbersAndPunctuationKeyboard];

		PSTextFieldSpecifier *numbersAndPunctuationKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[numbersAndPunctuationKeyboardTry setKeyboardType:2 autoCaps:NO autoCorrection:NO];
		[numbersAndPunctuationKeyboardTry setPlaceholder:@"Test Numbers and Punctuation keyboard"];
		[_specifiers addObject:numbersAndPunctuationKeyboardTry];

		PSSpecifier* urlKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keyboard optimized for URL entry. This keyboard type prominently features the period (“.”) and slash (“/”) characters and the “.com” string."];
		[urlKeyboardGroup setProperty:@"urlKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:urlKeyboardGroup];

		PSSpecifier *urlKeyboard = [PSSpecifier preferenceSpecifierNamed:@"URL"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[urlKeyboard setProperty:@"3" forKey:@"default"];
		[urlKeyboard setProperty:@"urlKeyboard" forKey:@"key"];
		[urlKeyboard setValues:values titles:titles];
		[urlKeyboard setProperty:kPackage forKey:@"defaults"];
		[urlKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[urlKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:urlKeyboard];

		PSTextFieldSpecifier *urlKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[urlKeyboardTry setKeyboardType:3 autoCaps:NO autoCorrection:NO];
		[urlKeyboardTry setPlaceholder:@"Test URL keyboard"];
		[_specifiers addObject:urlKeyboardTry];

		PSSpecifier* numberPadKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a numeric keypad designed for PIN entry. This keyboard type prominently features the numbers 0 through 9. This keyboard type does not support auto-capitalization."];
		[numberPadKeyboardGroup setProperty:@"numberPadKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:numberPadKeyboardGroup];

		PSSpecifier *numberPadKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Number Pad keyboard"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[numberPadKeyboard setProperty:@"4" forKey:@"default"];
		[numberPadKeyboard setProperty:@"numberPadKeyboard" forKey:@"key"];
		[numberPadKeyboard setValues:values titles:titles];
		[numberPadKeyboard setProperty:kPackage forKey:@"defaults"];
		[numberPadKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[numberPadKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:numberPadKeyboard];

		PSTextFieldSpecifier *numberPadKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[numberPadKeyboardTry setKeyboardType:4 autoCaps:NO autoCorrection:NO];
		[numberPadKeyboardTry setPlaceholder:@"Test Number Pad keyboard"];
		[_specifiers addObject:numberPadKeyboardTry];

		PSSpecifier* phonePadKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keypad designed for entering telephone numbers. This keyboard type prominently features the numbers 0 through 9 and the “*” and “#” characters. This keyboard type does not support auto-capitalization."];
		[phonePadKeyboardGroup setProperty:@"phonePadKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:phonePadKeyboardGroup];

		PSSpecifier *phonePadKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Phone Pad keyboard"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[phonePadKeyboard setProperty:@"5" forKey:@"default"];
		[phonePadKeyboard setProperty:@"phonePadKeyboard" forKey:@"key"];
		[phonePadKeyboard setValues:values titles:titles];
		[phonePadKeyboard setProperty:kPackage forKey:@"defaults"];
		[phonePadKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[phonePadKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:phonePadKeyboard];

		PSTextFieldSpecifier *phonePadKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[phonePadKeyboardTry setKeyboardType:5 autoCaps:NO autoCorrection:NO];
		[phonePadKeyboardTry setPlaceholder:@"Test Phone Pad keyboard"];
		[_specifiers addObject:phonePadKeyboardTry];

		PSSpecifier* namePhonePadKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keyboard optimized for alphabetic entry."];
		[namePhonePadKeyboardGroup setProperty:@"namePhonePadKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:namePhonePadKeyboardGroup];

		PSSpecifier *namePhonePadKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Name Phone Pad keyboard"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[namePhonePadKeyboard setProperty:@"6" forKey:@"default"];
		[namePhonePadKeyboard setProperty:@"namePhonePadKeyboard" forKey:@"key"];
		[namePhonePadKeyboard setValues:values titles:titles];
		[namePhonePadKeyboard setProperty:kPackage forKey:@"defaults"];
		[namePhonePadKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[namePhonePadKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:namePhonePadKeyboard];

		PSTextFieldSpecifier *namePhonePadKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[namePhonePadKeyboardTry setKeyboardType:6 autoCaps:NO autoCorrection:NO];
		[namePhonePadKeyboardTry setPlaceholder:@"Test Name Phone Pad keyboard"];
		[_specifiers addObject:namePhonePadKeyboardTry];

		PSSpecifier* emailAddressKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keyboard optimized for entering email addresses. This keyboard type prominently features the at (“@”), period (“.”) and space characters."];
		[emailAddressKeyboardGroup setProperty:@"emailAddressKeyboardGroup" forKey:@"key"];
		[_specifiers addObject:emailAddressKeyboardGroup];

		PSSpecifier *emailAddressKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Email Address"
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:NSClassFromString(@"PSListItemsController")
			cell:PSLinkListCell
			edit:nil
		];
		[emailAddressKeyboard setProperty:@"7" forKey:@"default"];
		[emailAddressKeyboard setProperty:@"emailAddressKeyboard" forKey:@"key"];
		[emailAddressKeyboard setValues:values titles:titles];
		[emailAddressKeyboard setProperty:kPackage forKey:@"defaults"];
		[emailAddressKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
		[emailAddressKeyboard setProperty:@"55" forKey:@"height"];
		[_specifiers addObject:emailAddressKeyboard];

		PSTextFieldSpecifier *emailAddressKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
			target:self
			set:@selector(setPreferenceValue:specifier:)
			get:@selector(readPreferenceValue:)
			detail:nil
			cell:PSEditTextCell
			edit:nil
		];
		[emailAddressKeyboardTry setKeyboardType:7 autoCaps:NO autoCorrection:NO];
		[emailAddressKeyboardTry setPlaceholder:@"Test Email Address keyboard"];
		[_specifiers addObject:emailAddressKeyboardTry];

//		if ( kIsiOS4_1AndUp ) {
			PSSpecifier* decimalPadKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keyboard with numbers and a decimal point."];
			[decimalPadKeyboardGroup setProperty:@"decimalPadKeyboardGroup" forKey:@"key"];
			[_specifiers addObject:decimalPadKeyboardGroup];

			PSSpecifier *decimalPadKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Decimal Pad keyboard"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:NSClassFromString(@"PSListItemsController")
				cell:PSLinkListCell
				edit:nil
			];
			[decimalPadKeyboard setProperty:@"8" forKey:@"default"];
			[decimalPadKeyboard setProperty:@"decimalPadKeyboard" forKey:@"key"];
			[decimalPadKeyboard setValues:values titles:titles];
			[decimalPadKeyboard setProperty:kPackage forKey:@"defaults"];
			[decimalPadKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
			[decimalPadKeyboard setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:decimalPadKeyboard];

			PSTextFieldSpecifier *decimalPadKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSEditTextCell
				edit:nil
			];
			[decimalPadKeyboardTry setKeyboardType:8 autoCaps:NO autoCorrection:NO];
			[decimalPadKeyboardTry setPlaceholder:@"Test Decimal Pad keyboard"];
			[_specifiers addObject:decimalPadKeyboardTry];
//		}

//		if ( kIsiOS5AndUp ) {
			PSSpecifier* twitterKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keyboard optimized for Twitter text entry, with easy access to the at (“@”) and hash (“#”) characters."];
			[twitterKeyboardGroup setProperty:@"twitterKeyboardGroup" forKey:@"key"];
			[_specifiers addObject:twitterKeyboardGroup];

			PSSpecifier *twitterKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Twitter keyboard"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:NSClassFromString(@"PSListItemsController")
				cell:PSLinkListCell
				edit:nil
			];
			[twitterKeyboard setProperty:@"9" forKey:@"default"];
			[twitterKeyboard setProperty:@"twitterKeyboard" forKey:@"key"];
			[twitterKeyboard setValues:values titles:titles];
			[twitterKeyboard setProperty:kPackage forKey:@"defaults"];
			[twitterKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
			[twitterKeyboard setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:twitterKeyboard];

			PSTextFieldSpecifier *twitterKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSEditTextCell
				edit:nil
			];
			[twitterKeyboardTry setKeyboardType:9 autoCaps:NO autoCorrection:NO];
			[twitterKeyboardTry setPlaceholder:@"Test Twitter keyboard"];
			[_specifiers addObject:twitterKeyboardTry];
//		}

//		if ( kIsiOS7AndUp ) {
			PSSpecifier* webSearchKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a keyboard optimized for web search terms and URL entry. This keyboard type prominently features the space and period (“.”) characters."];
			[webSearchKeyboardGroup setProperty:@"webSearchKeyboardGroup" forKey:@"key"];
			[_specifiers addObject:webSearchKeyboardGroup];

			PSSpecifier *webSearchKeyboard = [PSSpecifier preferenceSpecifierNamed:@"Web Search keyboard"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:NSClassFromString(@"PSListItemsController")
				cell:PSLinkListCell
				edit:nil
			];
			[webSearchKeyboard setProperty:@"10" forKey:@"default"];
			[webSearchKeyboard setProperty:@"webSearchKeyboard" forKey:@"key"];
			[webSearchKeyboard setValues:values titles:titles];
			[webSearchKeyboard setProperty:kPackage forKey:@"defaults"];
			[webSearchKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
			[webSearchKeyboard setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:webSearchKeyboard];

			PSTextFieldSpecifier *webSearchKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSEditTextCell
				edit:nil
			];
			[webSearchKeyboardTry setKeyboardType:10 autoCaps:NO autoCorrection:NO];
			[webSearchKeyboardTry setPlaceholder:@"Test Web Search keyboard"];
			[_specifiers addObject:webSearchKeyboardTry];
//		}

		if ( kIsiOS10AndUp ) {
			PSSpecifier* asciiCapableNumberPadKeyboardGroup = [PSSpecifier groupSpecifierWithHeader:@"" footer:@"Specifies a number pad that outputs only ASCII digits."];
			[asciiCapableNumberPadKeyboardGroup setProperty:@"asciiCapableNumberPadKeyboardGroup" forKey:@"key"];
			[_specifiers addObject:asciiCapableNumberPadKeyboardGroup];

			PSSpecifier *asciiCapableNumberPadKeyboard = [PSSpecifier preferenceSpecifierNamed:@"ASCII Capable Number Pad keyboard"
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:NSClassFromString(@"PSListItemsController")
				cell:PSLinkListCell
				edit:nil
			];
			[asciiCapableNumberPadKeyboard setProperty:@"11" forKey:@"default"];
			[asciiCapableNumberPadKeyboard setProperty:@"asciiCapableNumberPadKeyboard" forKey:@"key"];
			[asciiCapableNumberPadKeyboard setValues:values titles:titles];
			[asciiCapableNumberPadKeyboard setProperty:kPackage forKey:@"defaults"];
			[asciiCapableNumberPadKeyboard setProperty:kSettingsChanged forKey:@"PostNotification"];
			[asciiCapableNumberPadKeyboard setProperty:@"55" forKey:@"height"];
			[_specifiers addObject:asciiCapableNumberPadKeyboard];

			PSTextFieldSpecifier *asciiCapableNumberPadKeyboardTry = [PSTextFieldSpecifier preferenceSpecifierNamed:@""
				target:self
				set:@selector(setPreferenceValue:specifier:)
				get:@selector(readPreferenceValue:)
				detail:nil
				cell:PSEditTextCell
				edit:nil
			];
			[asciiCapableNumberPadKeyboardTry setKeyboardType:11 autoCaps:NO autoCorrection:NO];
			[asciiCapableNumberPadKeyboardTry setPlaceholder:@"Test ASCII Capable Number Pad keyboard"];
			[_specifiers addObject:asciiCapableNumberPadKeyboardTry];
		}
	}
	return _specifiers;
}
@end
