#import "SettingsDetailCell.h"

@implementation SettingsDetailCell

@synthesize textField;

#pragma mark -

- (void)dealloc
{
    //  We're performing a delayed release here to give delegate notification 
    //  messages time to propagate. Specifically, MyDetailController implements
    //  the -textFieldDidEndEditing: delegate method, which is sent by an
    //  instance of NSNotificationCenter during the next event cycle. Without
    //  the delay, the textField would get released before the message is sent.
    //  But the textField is an argument to that method, so the method would 
    //  be passed an invalid reference, which would be likely to crash the app.
    //
    [self.textField performSelector:@selector(release)
                     withObject:nil
                     afterDelay:1.0];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier
{
    self = [super initWithStyle:style reuseIdentifier:identifier];
    
    if (self == nil)
    { 
        return nil;
    }
    
    CGRect bounds = [[self contentView] bounds];
    CGRect rect = CGRectInset(bounds, 20.0, 10.0);
    self.textField = [[UITextField alloc] initWithFrame:rect];
    
    //  Set the keyboard's return key label to 'Next'.
    [self.textField setReturnKeyType:UIReturnKeyNext];
    
    //  Make the clear button appear automatically.
    [self.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    [self.textField setOpaque:YES];
	self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
	self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [[self contentView] addSubview:self.textField];
    return self;
}


//  Disable highlighting of currently selected cell.
//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    [super setSelected:selected animated:NO];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

@end
