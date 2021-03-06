/* 
 Copyright (c) 2013 Alun Bestor and contributors. All rights reserved.
 This source file is released under the GNU General Public License 2.0. A full copy of this license
 can be found in this XCode project at Resources/English.lproj/BoxerHelp/pages/legalese.html, or read
 online at [http://www.gnu.org/licenses/gpl-2.0.txt].
 */

#import "BXApplication.h"
#import "BXBaseAppController+BXHotKeys.h"

@implementation BXApplication

- (void) sendEvent: (NSEvent *)theEvent
{
    //Dispatch media key events.
    if (self.delegate && theEvent.type == NSEventTypeSystemDefined && theEvent.subtype == 8)
    {
        [(BXBaseAppController *)self.delegate mediaKeyPressed: theEvent];
        return;
    }
    
    //Fix Cmd-modified key-up events not being dispatched to the key window.
    else if (self.keyWindow && theEvent.type == NSEventTypeKeyUp && (theEvent.modifierFlags & NSEventModifierFlagCommand) == NSEventModifierFlagCommand)
    {
        //NOTE: unlike a regular keyUp, the event will have a nil window.
        //If this becomes an issue, we could recreate the event and dispatch the copy.
		[self.keyWindow sendEvent: theEvent];
	}
    
    else
    {
		[super sendEvent: theEvent];
	}
}

@end
