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

NSMutableDictionary * tweakSettings;

static bool enableTweak;

static int uiStyle;

static long long defaultKeyboard;
static long long asciiCapableKeyboard;
static long long numbersAndPunctuationKeyboard;
static long long urlKeyboard;
static long long numberPadKeyboard;
static long long phonePadKeyboard;
static long long namePhonePadKeyboard;
static long long emailAddressKeyboard;
static long long decimalPadKeyboard;
static long long twitterKeyboard;
static long long webSearchKeyboard;
static long long asciiCapableNumberPadKeyboard;

static long long returnKeyTypeDefault;
static long long returnKeyTypeGo;
static long long returnKeyTypeGoogle;
static long long returnKeyTypeJoin;
static long long returnKeyTypeNext;
static long long returnKeyTypeRoute;
static long long returnKeyTypeSearch;
static long long returnKeyTypeSend;
static long long returnKeyTypeYahoo;
static long long returnKeyTypeDone;
static long long returnKeyTypeEmergencyCall;
static long long returnKeyTypeContinue;

static long long keyboardDismissMode;

static int trackpadMode;

static int returnKeyStyling;

static int dictationButton;

static int shouldShowInternationalKey;

static int selectingSkinToneForEmoji;

static int oneHandedKeyboard;

static int useBlueThemingForKey;

static int feedbackType;

static int feedbackWhen;

static void SettingsChanged() {
	CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR(kPackageName), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if(keyList) {
		tweakSettings = (NSMutableDictionary *)CFBridgingRelease(
			CFPreferencesCopyMultiple(
				keyList,
				CFSTR(kPackageName),
				kCFPreferencesCurrentUser,
				kCFPreferencesAnyHost
			)
		);
		CFRelease(keyList);
	} else {
		tweakSettings = nil;
	}
	if (!tweakSettings) {
		tweakSettings = [NSMutableDictionary dictionaryWithContentsOfFile:kUserSettingsFile];
	}

	enableTweak = [([tweakSettings objectForKey:@"enableTweak"] ?: @(YES)) boolValue];

	uiStyle = [([tweakSettings valueForKey:@"uiStyle"] ?: @(999)) integerValue];

	defaultKeyboard = [([tweakSettings valueForKey:@"defaultKeyboard"] ?: @(0)) integerValue];
	asciiCapableKeyboard = [([tweakSettings valueForKey:@"asciiCapableKeyboard"] ?: @(1)) integerValue];
	numbersAndPunctuationKeyboard = [([tweakSettings valueForKey:@"numbersAndPunctuationKeyboard"] ?: @(2)) integerValue];
	urlKeyboard = [([tweakSettings valueForKey:@"urlKeyboard"] ?: @(3)) integerValue];
	numberPadKeyboard = [([tweakSettings valueForKey:@"numberPadKeyboard"] ?: @(4)) integerValue];
	phonePadKeyboard = [([tweakSettings valueForKey:@"phonePadKeyboard"] ?: @(5)) integerValue];
	namePhonePadKeyboard = [([tweakSettings valueForKey:@"namePhonePadKeyboard"] ?: @(6)) integerValue];
	emailAddressKeyboard = [([tweakSettings valueForKey:@"emailAddressKeyboard"] ?: @(7)) integerValue];
	decimalPadKeyboard = [([tweakSettings valueForKey:@"decimalPadKeyboard"] ?: @(8)) integerValue];
	twitterKeyboard = [([tweakSettings valueForKey:@"twitterKeyboard"] ?: @(9)) integerValue];
	webSearchKeyboard = [([tweakSettings valueForKey:@"webSearchKeyboard"] ?: @(10)) integerValue];
	asciiCapableNumberPadKeyboard = [([tweakSettings valueForKey:@"asciiCapableNumberPadKeyboard"] ?: @(11)) integerValue];

	returnKeyTypeDefault = [([tweakSettings valueForKey:@"returnKeyTypeDefault"] ?: @(0)) integerValue];
	returnKeyTypeGo = [([tweakSettings valueForKey:@"returnKeyTypeGo"] ?: @(1)) integerValue];
	returnKeyTypeGoogle = [([tweakSettings valueForKey:@"returnKeyTypeGoogle"] ?: @(2)) integerValue];
	returnKeyTypeJoin = [([tweakSettings valueForKey:@"returnKeyTypeJoin"] ?: @(3)) integerValue];
	returnKeyTypeNext = [([tweakSettings valueForKey:@"returnKeyTypeNext"] ?: @(4)) integerValue];
	returnKeyTypeRoute = [([tweakSettings valueForKey:@"returnKeyTypeRoute"] ?: @(5)) integerValue];
	returnKeyTypeSearch = [([tweakSettings valueForKey:@"returnKeyTypeSearch"] ?: @(6)) integerValue];
	returnKeyTypeSend = [([tweakSettings valueForKey:@"returnKeyTypeSend"] ?: @(7)) integerValue];
	returnKeyTypeYahoo = [([tweakSettings valueForKey:@"returnKeyTypeYahoo"] ?: @(8)) integerValue];
	returnKeyTypeDone = [([tweakSettings valueForKey:@"returnKeyTypeDone"] ?: @(9)) integerValue];
	returnKeyTypeEmergencyCall = [([tweakSettings valueForKey:@"returnKeyTypeEmergencyCall"] ?: @(10)) integerValue];
	returnKeyTypeContinue = [([tweakSettings valueForKey:@"returnKeyTypeContinue"] ?: @(11)) integerValue];

	keyboardDismissMode = [([tweakSettings valueForKey:@"keyboardDismissMode"] ?: @(999)) integerValue];

	trackpadMode = [([tweakSettings valueForKey:@"trackpadMode"] ?: @(999)) integerValue];

	returnKeyStyling = [([tweakSettings valueForKey:@"returnKeyStyling"] ?: @(999)) integerValue];

	dictationButton = [([tweakSettings objectForKey:@"dictationButton"] ?: @(999)) integerValue];

	shouldShowInternationalKey = [([tweakSettings objectForKey:@"shouldShowInternationalKey"] ?: @(999)) integerValue];

	selectingSkinToneForEmoji = [([tweakSettings objectForKey:@"selectingSkinToneForEmoji"] ?: @(999)) integerValue];

	oneHandedKeyboard = [([tweakSettings valueForKey:@"oneHandedKeyboard"] ?: @(999)) integerValue];

	useBlueThemingForKey = [([tweakSettings objectForKey:@"useBlueThemingForKey"] ?: @(999)) integerValue];

	feedbackType = [([tweakSettings objectForKey:@"feedbackType"] ?: @(0)) integerValue];

	feedbackWhen = [([tweakSettings objectForKey:@"feedbackWhen"] ?: @(0)) integerValue];
}

static void receivedNotification(
	CFNotificationCenterRef center,
	void *observer,
	CFStringRef name,
	const void *object,
	CFDictionaryRef userInfo
) {
	SettingsChanged();
}

%hook UITextInputTraits
- (long long)keyboardAppearance {
	long long origValue = %orig;
	if ( enableTweak && uiStyle != 999 ) {
		return uiStyle;
	}
	return origValue;
}
- (long long)keyboardType {
	long long origValue = %orig;
	if ( enableTweak && origValue == 0 ) {
		return defaultKeyboard;
	} else if ( enableTweak && origValue == 1 ) {
		return asciiCapableKeyboard;
	} else if ( enableTweak && origValue == 2 ) {
		return numbersAndPunctuationKeyboard;
	} else if ( enableTweak && origValue == 3 ) {
		return urlKeyboard;
	} else if ( enableTweak && origValue == 4 ) {
		return numberPadKeyboard;
	} else if ( enableTweak && origValue == 5 ) {
		return phonePadKeyboard;
	} else if ( enableTweak && origValue == 6 ) {
		return namePhonePadKeyboard;
	} else if ( enableTweak && origValue == 7 ) {
		return emailAddressKeyboard;
	} else if ( enableTweak && origValue == 8 ) {
		return decimalPadKeyboard;
	} else if ( enableTweak && origValue == 9 ) {
		return twitterKeyboard;
	} else if ( enableTweak && origValue == 10 ) {
		return webSearchKeyboard;
	} else if ( enableTweak && origValue == 11 ) {
		return asciiCapableNumberPadKeyboard;
	}
	return origValue;
}
- (void)setKeyboardType:(long long)keyboardType {
	if ( enableTweak && keyboardType == 0 ) {
		keyboardType = defaultKeyboard;
	} else if ( enableTweak && keyboardType == 1 ) {
		keyboardType = asciiCapableKeyboard;
	} else if ( enableTweak && keyboardType == 2 ) {
		keyboardType = numbersAndPunctuationKeyboard;
	} else if ( enableTweak && keyboardType == 3 ) {
		keyboardType = urlKeyboard;
	} else if ( enableTweak && keyboardType == 4 ) {
		keyboardType = numberPadKeyboard;
	} else if ( enableTweak && keyboardType == 5 ) {
		keyboardType = phonePadKeyboard;
	} else if ( enableTweak && keyboardType == 6 ) {
		keyboardType = namePhonePadKeyboard;
	} else if ( enableTweak && keyboardType == 7 ) {
		keyboardType = emailAddressKeyboard;
	} else if ( enableTweak && keyboardType == 8 ) {
		keyboardType = decimalPadKeyboard;
	} else if ( enableTweak && keyboardType == 9 ) {
		keyboardType = twitterKeyboard;
	} else if ( enableTweak && keyboardType == 10 ) {
		keyboardType = webSearchKeyboard;
	} else if ( enableTweak && keyboardType == 11 ) {
		keyboardType = asciiCapableNumberPadKeyboard;
	}
	%orig(keyboardType);
}
- (long long)returnKeyType {
	long long origValue = %orig;
	if ( origValue == 0 && enableTweak ) {
		return returnKeyTypeDefault;
	} else if ( origValue == 1 && enableTweak ) {
		return returnKeyTypeGo;
	} else if ( origValue == 2 && enableTweak ) {
		return returnKeyTypeGoogle;
	} else if ( origValue == 3 && enableTweak ) {
		return returnKeyTypeJoin;
	} else if ( origValue == 4 && enableTweak ) {
		return returnKeyTypeNext;
	} else if ( origValue == 5 && enableTweak ) {
		return returnKeyTypeRoute;
	} else if ( origValue == 6 && enableTweak ) {
		return returnKeyTypeSearch;
	} else if ( origValue == 7 && enableTweak ) {
		return returnKeyTypeSend;
	} else if ( origValue == 8 && enableTweak ) {
		return returnKeyTypeYahoo;
	} else if ( origValue == 9 && enableTweak ) {
		return returnKeyTypeDone;
	} else if ( origValue == 10 && enableTweak ) {
		return returnKeyTypeEmergencyCall;
	} else if ( origValue == 11 && enableTweak ) {
		return returnKeyTypeContinue;
	}
	return origValue;
}
%end

%hook UIScrollView
- (long long)keyboardDismissMode {
	long long origValue = %orig;
	if ( enableTweak && keyboardDismissMode != 999 ) {
		if (
			![[self _viewControllerForAncestor] isKindOfClass:%c(UICompatibilityInputViewController)]
			&&
			![[self _viewControllerForAncestor] isKindOfClass:%c(UICandidateViewController)]
			&&
			![[self _viewControllerForAncestor] isKindOfClass:%c(UIInputViewController)]
		) {
			return keyboardDismissMode;
		}
	}
	return origValue;
}
%end

%hook UIKeyboardEmojiCollectionInputView
- (int)skinToneWasUsedForEmoji:(id)arg1 {
	int origValue = %orig;
	if ( enableTweak && selectingSkinToneForEmoji != 999 ) {
		return selectingSkinToneForEmoji;
	}
	return origValue;
}
%end

%hook UIKeyboardEmojiPreferences
- (int)hasDisplayedSkinToneHelp {
	int origValue = %orig;
	if ( enableTweak && selectingSkinToneForEmoji != 999 ) {
		return selectingSkinToneForEmoji;
	}
	return origValue;
}
%end

%hook UIKeyboardLayoutStar
- (long long)currentHandBias {
	long long origValue = %orig;
	if ( enableTweak && oneHandedKeyboard != 999 ) {
		return oneHandedKeyboard;
	}
	return origValue;
}
- (void)_setBiasEscapeButtonVisible:(int)arg1 {
	if ( enableTweak && oneHandedKeyboard != 999 ) {
		%orig(0);
	} else {
		%orig;
	}
}
- (int)shouldShowDictationKey {
	int origValue = %orig;
	if ( enableTweak && dictationButton != 999 ) {
		return dictationButton;
	}
	return origValue;
}
//		- (void)playKeyClickSoundForKey:(id)arg1 {
//			%orig;
//			NSLog(@"[KeyboardController] UIKeyboardLayoutStar playKeyClickSoundForKey arg1 = %@", arg1);
//		}
//		- (void)playKeyClickSoundOnDownForKey:(id)arg1 {
//			%orig;
//			NSLog(@"[KeyboardController] UIKeyboardLayoutStar playKeyClickSoundOnDownForKey arg1 = %@", arg1);
//		}
//		- (void)playKeyClickSoundOnUpForKey:(id)arg1 {
//			%orig;
//			NSLog(@"[KeyboardController] UIKeyboardLayoutStar playKeyClickSoundOnUpForKey arg1 = %@", arg1);
//		}
//		- (void)playKeyReleaseSoundForKey:(id)arg1 {
//			%orig;
//			NSLog(@"[KeyboardController] UIKeyboardLayoutStar playKeyReleaseSoundForKey arg1 = %@", arg1);
//		}
%end

%hook UIKeyboardSplitTransitionView
- (int)showDictationKey {
	int origValue = %orig;
	if ( enableTweak && dictationButton != 999 ) {
		return dictationButton;
	}
	return origValue;
}
%end

%hook UIPeripheralHost
- (int)hasDictationKeyboard {
	int origValue = %orig;
	if ( enableTweak && dictationButton != 999 ) {
		return dictationButton;
	}
	return origValue;
}
%end

%hook UIInputSwitcherView
- (int)_isHandBiasSwitchVisible {
	int origValue = %orig;
	if ( enableTweak && oneHandedKeyboard != 999 ) {
		return 0;
	}
	return origValue;
}
%end

%hook UIKBRenderFactory
- (int)useBlueThemingForKey:(id)arg1 {
	int origValue = %orig;
	if ( enableTweak && useBlueThemingForKey != 999 ) {
		return useBlueThemingForKey;
	}
	return origValue;
}
%end


%group iOS8

%hook UITextInputTraits
- (int)suppressReturnKeyStyling {
	int origValue = %orig;
	if ( enableTweak && returnKeyStyling != 999 ) {
		return !returnKeyStyling;
	}
	return origValue;
}
%end

%end


%group iOS9_3_4

%hook UITextInputTraits
- (int)forceDisableDictation {
	int origValue = %orig;
	if ( enableTweak && dictationButton != 999 ) {
		return !dictationButton;
	}
	return origValue;
}
%end

%end


%group iOS10

%hook UITextInputTraits
- (int)forceEnableDictation {
	int origValue = %orig;
	if ( enableTweak && dictationButton != 999 ) {
		return dictationButton;
	}
	return origValue;
}
%end

%hook UIKeyboardImpl
- (bool)shouldShowDictationKey {
	int origValue = %orig;
	if ( enableTweak && dictationButton != 999 ) {
		return dictationButton;
	}
	return origValue;
}
%end

%end


%group iOS11

%hook UIKeyboardImpl
- (int)shouldShowInternationalKey {
	int origValue = %orig;
	if ( enableTweak && shouldShowInternationalKey != 999 ) {
		return shouldShowInternationalKey;
	}
	return origValue;
}
%end

%end


%group iOS12

%hook _UIKeyboardTextSelectionInteraction
- (bool)forceTouchGestureRecognizerShouldBegin:(id)arg1 {
	int origValue = %orig;
	if ( enableTweak && trackpadMode == 404 ) {
		return NO;
	} else if ( enableTweak && trackpadMode == 505 ) {
		return NO;
	} else if ( enableTweak && trackpadMode == 1 ) {
		return YES;
	}
	return origValue;
}
- (bool)gestureRecognizerShouldBegin:(id)arg1 {
	int origValue = %orig;
	if ( enableTweak && trackpadMode == 404 ) {
		return NO;
	} else if ( enableTweak && trackpadMode == 505 ) {
		return YES;
	} else if ( enableTweak && trackpadMode == 1 ) {
		return YES;
	}
	return origValue;
}
%end

%end

//	%hook UIKeyboardLayout
//	- (void)touchDown:(id)arg1 {
//		%orig;
//	NSLog(@"[KeyboardController] UIKeyboardLayout touchDown arg1 = %@", arg1);
//		if (@available(iOS 13, *)) {
//			if ( ![[NSProcessInfo processInfo] isLowPowerModeEnabled] ) {
//				int feedbackTypeName = 0;
//				if ( feedbackWhen == 1 || feedbackType == 0 ) {
//					return;
//				} else if ( feedbackType == 1 ) {
//					UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc] init];
//					[generator prepare];
//					[generator selectionChanged];
//					generator = nil;
//				} else if ( feedbackType == 2 ) {
//					feedbackTypeName = UIImpactFeedbackStyleLight;
//				} else if ( feedbackType == 3 ) {
//					feedbackTypeName = UIImpactFeedbackStyleMedium;
//				} else if ( feedbackType == 4 ) {
//					feedbackTypeName = UIImpactFeedbackStyleHeavy;
//				} else if ( feedbackType == 5 ) {
//					feedbackTypeName = UIImpactFeedbackStyleSoft;
//				} else if ( feedbackType == 6 ) {
//					feedbackTypeName = UIImpactFeedbackStyleRigid;
//				} else if ( feedbackType > 505 ) {
//					AudioServicesPlaySystemSound(feedbackType);
//				}
//				if ( feedbackTypeName > 0 ) {
//					UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc]initWithStyle:feedbackTypeName];
//					[generator prepare];
//					[generator impactOccurred];
//					generator = nil;
//				}
//			}
//		}
//	}
//	- (void)touchUp:(id)arg1 {
//		%orig;
//		NSLog(@"[KeyboardController] UIKeyboardLayout touchUp arg1 = %@", arg1);
//		if (@available(iOS 13, *)) {
//			if ( ![[NSProcessInfo processInfo] isLowPowerModeEnabled] ) {
//				int feedbackTypeName = 0;
//				if ( feedbackWhen == 0 || feedbackType == 0 ) {
//					return;
//				} else if ( feedbackType == 1 && feedbackWhen == 1 ) {
//					UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc] init];
//					[generator prepare];
//					[generator selectionChanged];
//					generator = nil;
//				} else if (feedbackType == 2) {
//					feedbackTypeName = UIImpactFeedbackStyleLight;
//				} else if ( feedbackType == 3 ) {
//					feedbackTypeName = UIImpactFeedbackStyleMedium;
//				} else if ( feedbackType == 4 ) {
//					feedbackTypeName = UIImpactFeedbackStyleHeavy;
//				} else if ( feedbackType == 5 ) {
//					feedbackTypeName = UIImpactFeedbackStyleSoft;
//				} else if ( feedbackType == 6 ) {
//					feedbackTypeName = UIImpactFeedbackStyleRigid;
//				} else if ( feedbackType > 505 ) {
//					AudioServicesPlaySystemSound(feedbackType);
//				}
//				if ( feedbackTypeName > 0 ) {
//					UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc]initWithStyle:feedbackTypeName];
//					[generator prepare];
//					[generator impactOccurred];
//					generator = nil;
//				}
//			}
//		}
//	}
//	%end

%ctor {
	if ( [ [ [ [NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"SpringBoard.app" ]
	||
	[ [ [ [NSProcessInfo processInfo] arguments] objectAtIndex:0] containsString:@"/Application" ] ) {
		SettingsChanged();
		CFNotificationCenterAddObserver(
			CFNotificationCenterGetDarwinNotifyCenter(),
			NULL,
			receivedNotification,
			CFSTR("com.tomaszpoliszuk.keyboardcontroller.settingschanged"),
			NULL,
			CFNotificationSuspensionBehaviorDeliverImmediately
		);
		if (@available(iOS 8, *)) {
			%init(iOS8);
		}
		if (@available(iOS 9.3.4, *)) {
			%init(iOS9_3_4);
		}
		if (@available(iOS 10, *)) {
			%init(iOS10);
		}
		if (@available(iOS 11, *)) {
			%init(iOS11);
		}
		if (@available(iOS 12, *)) {
			%init(iOS12);
		}
		%init;
	}
}
