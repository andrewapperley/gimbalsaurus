//
//  gimbalsaurus_meta_private.h
//  gimbalsaurus
//
//  Created by Andrew Apperley on 2023-07-28.
//

#ifndef gimbalsaurus_meta_private_h
#define gimbalsaurus_meta_private_h

#import <gimbalsaurus/GblSaurusType.h>
#import <gimbalsaurus/GblSaurusClass.h>

#define GBL_SAURUS_TYPE_PRIVATE \
@interface GblSaurusType () \
@property(nonatomic)GblType _type; \
@end

#define GBL_SAURUS_CLASS_PRIVATE \
@interface GblSaurusClass () \
@property(nonatomic)GblSaurusClass *_default; \
@property(nonatomic)GblSaurusClass *_super; \
@property(nonatomic)GblClass *_class; \
@end

#endif /* gimbalsaurus_meta_private_h */
