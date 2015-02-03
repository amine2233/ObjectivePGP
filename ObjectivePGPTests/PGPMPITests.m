//
//  PGPMPITests.m
//  ObjectivePGP
//
//  Created by Marcin Krzyzanowski on 01/02/15.
//  Copyright (c) 2015 Marcin Krzyżanowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PGPMPI.h"

@interface PGPMPITests : XCTestCase

@end

@implementation PGPMPITests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testReadWrite
{
    Byte mpiBytes[] = {0x08, 0x00, 0xD0,0xB3,0x0C,0xDE,0xA4,0xD3,0x28,0x87,0x5F,0xEB,0x60,0x6B,0x92,0xF8,0x93,0xF3,0x11,0xA2,0x22,0x6F,0xC5,0xF4,0xF5,0x67,0x64,0x2C,0xA6,0x36,0x62,0xC0,0x14,0xF0,0x4C,0x25,0xFB,0x4E,0x05,0x6E,0x39,0x42,0xC8,0xA9,0x6B,0xCD,0xC9,0x0C,0x4D,0xFC,0x6D,0x68,0xAB,0x75,0x73,0x08,0x2C,0xFD,0x69,0xA2,0x57,0x06,0xE1,0xF6,0xDF,0x2C,0x86,0xE6,0x07,0xDA,0xAD,0x21,0x89,0x5F,0xD7,0xB4,0x18,0xB0,0xC5,0x6B,0x39,0xDE,0x5F,0xA7,0x88,0x99,0x0F,0x5F,0x9D,0xAF,0x6F,0xAB,0x13,0x51,0x69,0xBA,0x52,0xCB,0x7E,0xE9,0x1A,0x49,0x79,0x55,0xBD,0x5D,0x90,0xCE,0x59,0xDF,0x1C,0xBB,0xDD,0x6E,0xE4,0xB9,0x04,0xDA,0x05,0x85,0x30,0x56,0xB1,0x8E,0x35,0xD5,0x46,0xFE,0xD8,0x55,0x07,0x48,0x1E,0x26,0x42,0x85,0x37,0x81,0xA8,0xE8,0xE6,0x99,0x7D,0x4B,0x3D,0x6B,0xEE,0xAD,0x15,0x01,0xB5,0x31,0xA6,0xB8,0xF0,0x36,0x93,0x59,0x0A,0xE2,0xAC,0x5C,0x32,0xF0,0xB4,0xF5,0x1A,0xD6,0xF4,0x7D,0x6B,0xA5,0x62,0x9C,0x8B,0x2D,0x8D,0x1D,0xC5,0x77,0x23,0x3F,0xB6,0x77,0x43,0xFC,0x0E,0x80,0x6A,0x1F,0xB9,0xF0,0x69,0x18,0x8B,0x71,0x94,0xD2,0xA6,0x8E,0x1A,0xEF,0x7F,0xC7,0x96,0x35,0xCC,0xC0,0x1C,0x43,0x52,0x4C,0xF9,0x54,0xD4,0xA7,0x48,0xA5,0x1E,0xC2,0xD8,0x31,0x6A,0xFB,0x35,0xAC,0x05,0x20,0x66,0x7A,0xFC,0xFD,0x20,0x8A,0xAC,0xA9,0x8E,0x05,0xA2,0xA9,0xE0,0xF4,0x1B,0xFD,0xF5,0xD1,0x01,0x6A,0x34,0x13,0x0E,0x69,0xDE,0xD2,0x82,0x73,0x7F,0xDB};
    NSInputStream *inputStream = [NSInputStream inputStreamWithData:[NSData dataWithBytes:mpiBytes length:sizeof(mpiBytes)]];
    [inputStream open];
    NSError *error = nil;
    PGPMPI *mpi = [PGPMPI readFromStream:inputStream error:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(mpi);
    XCTAssertNotNil(mpi.data);
    XCTAssertEqual(mpi.data.length, sizeof(mpiBytes) - 2);
    [inputStream close];
    
    NSOutputStream *outputStream = [NSOutputStream outputStreamToMemory];
    [outputStream open];
    NSError *writeError = nil;
    [mpi writeToStream:outputStream error:&writeError];
    XCTAssertNil(writeError);
    NSData *writtenData = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    XCTAssertNotNil(writtenData);
    [outputStream close];
}
@end