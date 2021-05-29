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


#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

NSString *const domainString = @"com.tomaszpoliszuk.keyboardcontroller";

#define kPackage @"com.tomaszpoliszuk.keyboardcontroller"
#define kSettingsChanged @"com.tomaszpoliszuk.keyboardcontroller.settingschanged"

#define kIsiOS4_1AndUp (kCFCoreFoundationVersionNumber >= 550.38)
#define kIsiOS5AndUp (kCFCoreFoundationVersionNumber >= 675.00)
#define kIsiOS7AndUp (kCFCoreFoundationVersionNumber >= 847.20)
#define kIsiOS8AndUp (kCFCoreFoundationVersionNumber >= 1140.10)

#define kIsiOS9AndUp (kCFCoreFoundationVersionNumber >= 1240.10)
#define kIsiOS10AndUp (kCFCoreFoundationVersionNumber >= 1348.00)
#define kIsiOS11AndUp (kCFCoreFoundationVersionNumber >= 1443.00)
#define kIsiOS12AndUp (kCFCoreFoundationVersionNumber >= 1556.00)
#define kIsiOS13AndUp (kCFCoreFoundationVersionNumber >= 1665.15)


@interface UIDevice (KeyboardController)
+ (id)currentDevice;
- (bool)_supportsForceTouch;
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

@interface KeyboardControllerMainSettings : PSListController {
	NSMutableArray *removeSpecifiers;
}
@end

@interface KeyboardControllerKeyboardTypeSettings : PSListController
@end

@interface KeyboardControllerReturnKeyTypeSettings : PSListController
@end

@interface KeyboardControllerKeyboardOptions : PSListController
@end

@interface KeyboardControllerBetaOptions : PSListController
@end



