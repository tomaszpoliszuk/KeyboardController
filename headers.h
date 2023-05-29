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


#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
//	#import <AudioToolbox/AudioToolbox.h>

#define kPackageName "com.tomaszpoliszuk.keyboardcontroller"
#define kSettingsChanged @"com.tomaszpoliszuk.keyboardcontroller.settingschanged"
#define kUserSettingsFile @"/var/mobile/Library/Preferences/com.tomaszpoliszuk.keyboardcontroller.plist"

@interface UIView (KeyboardController)
-(id)_viewControllerForAncestor;
@end

@interface UIDevice (KeyboardController)
@property (getter=_feedbackSupportLevel, nonatomic, readonly) long long feedbackSupportLevel;
+ (id)currentDevice;
- (bool)_supportsForceTouch;
- (id)_tapticEngine;
@end

@interface NSMutableArray (KeyboardController)
- (void)addObject:(id)arg1;
@end

@interface PSSpecifier (KeyboardController)
+ (id)buttonSpecifierWithTitle:(id)arg1 target:(id)arg2 action:(SEL)arg3 confirmationInfo:(id)arg4;
+ (id)groupSpecifierWithHeader:(id)arg1 footer:(id)arg2;
+ (id)defaultTextInputTraits;
+ (id)emptyGroupSpecifier;
- (void)setValues:(id)arg1 titles:(id)arg2;
- (void)setValues:(id)arg1 titles:(id)arg2 shortTitles:(id)arg3;
- (void)setupIconImageWithPath:(id)arg1;
- (void)setKeyboardType:(long long)arg1 autoCaps:(int)arg2 autoCorrection:(int)arg3;
@end

@interface PSTextFieldSpecifier : PSSpecifier
- (void)setPlaceholder:(id)arg1;
@end

@interface UIKeyboardCache : NSObject
+ (id)sharedInstance;
- (void)purge;
- (void)clearNonPersistentCache;
@end


@interface PSListController (KeyboardController)
@end

@interface KeyboardControllerMainSettings : PSListController
@property (nonatomic, strong) NSMutableArray *standardSpecifiers;
@end

@interface KeyboardControllerKeyboardTypeSettings : PSListController
@end

@interface KeyboardControllerReturnKeyTypeSettings : PSListController
@end

@interface KeyboardControllerKeyboardOptions : PSListController
@end

@interface KeyboardControllerBetaOptions : PSListController
@end



