package UETRV_ECore
 
object flash {
var im_arr = Array( Array(0x55, 0xaa, 0x33, 0xcc), 
                    Array(0x00, 0x00, 0x00, 0x10),
                    Array(0x00, 0x00, 0x00, 0x13),
                    Array(0x00, 0x40, 0x00, 0x6f),
                    Array(0x00, 0x00, 0x21, 0x17),
                    Array(0xff, 0x81, 0x01, 0x13),
                    Array(0x00, 0x00, 0x05, 0x13),
                    Array(0x00, 0x00, 0x05, 0x93),
                    Array(0x0d, 0x80, 0x00, 0xef),
                    Array(0xfe, 0x01, 0x01, 0x13),
                    Array(0x00, 0x81, 0x2e, 0x23),
                    Array(0x02, 0x01, 0x04, 0x13),
                    Array(0x00, 0x05, 0x07, 0x93),
                    Array(0xfe, 0xf4, 0x07, 0xa3),
                    Array(0x00, 0x00, 0x27, 0xb7),
                    Array(0xfe, 0xf4, 0x47, 0x03),
                    Array(0x00, 0xe7, 0x81, 0x23),
                    Array(0x00, 0x00, 0x00, 0x13),
                    Array(0x01, 0xc1, 0x24, 0x03),
                    Array(0x02, 0x01, 0x01, 0x13),
                    Array(0x00, 0x00, 0x80, 0x67),
                    Array(0xfe, 0x01, 0x01, 0x13),
                    Array(0x00, 0x81, 0x2e, 0x23),
                    Array(0x02, 0x01, 0x04, 0x13),
                    Array(0x00, 0x05, 0x07, 0x93),
                    Array(0xfe, 0xf4, 0x07, 0xa3),
                    Array(0x00, 0x00, 0x00, 0x13),
                    Array(0x00, 0x00, 0x27, 0xb7),
                    Array(0x00, 0x47, 0xc7, 0x83),
                    Array(0x0f, 0xf7, 0xf7, 0x93),
                    Array(0x00, 0x27, 0xf7, 0x93),
                    Array(0xfe, 0x07, 0x88, 0xe3),
                    Array(0x00, 0x00, 0x27, 0xb7),
                    Array(0xfe, 0xf4, 0x47, 0x03),
                    Array(0x00, 0xe7, 0x80, 0xa3),
                    Array(0x00, 0x00, 0x00, 0x13),
                    Array(0x01, 0xc1, 0x24, 0x03),
                    Array(0x02, 0x01, 0x01, 0x13),
                    Array(0x00, 0x00, 0x80, 0x67),
                    Array(0xfd, 0x01, 0x01, 0x13),
                    Array(0x02, 0x11, 0x26, 0x23),
                    Array(0x02, 0x81, 0x24, 0x23),
                    Array(0x03, 0x01, 0x04, 0x13),
                    Array(0xfc, 0xa4, 0x2e, 0x23),
                    Array(0xfe, 0x04, 0x07, 0xa3),
                    Array(0x01, 0x00, 0x00, 0x6f),
                    Array(0xfe, 0xf4, 0x47, 0x83),
                    Array(0x00, 0x07, 0x85, 0x13),
                    Array(0xf9, 0x5f, 0xf0, 0xef),
                    Array(0xfd, 0xc4, 0x27, 0x83),
                    Array(0x00, 0x17, 0x87, 0x13),
                    Array(0xfc, 0xe4, 0x2e, 0x23),
                    Array(0x00, 0x07, 0xc7, 0x83),
                    Array(0xfe, 0xf4, 0x07, 0xa3),
                    Array(0xfe, 0xf4, 0x47, 0x83),
                    Array(0xfc, 0x07, 0x9e, 0xe3),
                    Array(0x00, 0x00, 0x00, 0x13),
                    Array(0x00, 0x00, 0x00, 0x13),
                    Array(0x02, 0xc1, 0x20, 0x83),
                    Array(0x02, 0x81, 0x24, 0x03),
                    Array(0x03, 0x01, 0x01, 0x13),
                    Array(0x00, 0x00, 0x80, 0x67),
                    Array(0xfe, 0x01, 0x01, 0x13),
                    Array(0x00, 0x11, 0x2e, 0x23),
                    Array(0x00, 0x81, 0x2c, 0x23),
                    Array(0x02, 0x01, 0x04, 0x13),
                    Array(0xfe, 0x04, 0x07, 0xa3),
                    Array(0xfe, 0x04, 0x07, 0xa3),
                    Array(0x02, 0x80, 0x00, 0x6f),
                    Array(0xfe, 0xf4, 0x47, 0x83),
                    Array(0x14, 0x00, 0x07, 0x13),
                    Array(0x00, 0xf7, 0x07, 0xb3),
                    Array(0x00, 0x07, 0xc7, 0x83),
                    Array(0x00, 0x07, 0x85, 0x13),
                    Array(0xf2, 0xdf, 0xf0, 0xef),
                    Array(0xfe, 0xf4, 0x47, 0x83),
                    Array(0x00, 0x17, 0x87, 0x93),
                    Array(0xfe, 0xf4, 0x07, 0xa3),
                    Array(0xfe, 0xf4, 0x47, 0x03),
                    Array(0x00, 0x40, 0x07, 0x93),
                    Array(0xfc, 0xe7, 0xfa, 0xe3),
                    Array(0x00, 0x00, 0x00, 0x6f),
                    Array(0x6c, 0x6c, 0x65, 0x48),
                    Array(0x00, 0x00, 0x00, 0x6f),
 ) 
 }