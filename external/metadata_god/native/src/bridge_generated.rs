#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.72.1.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

// Section: wire functions

fn wire_read_metadata_impl(port_: MessagePort, file: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "read_metadata",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file = file.wire2api();
            move |task_callback| read_metadata(api_file)
        },
    )
}
fn wire_write_metadata_impl(
    port_: MessagePort,
    file: impl Wire2Api<String> + UnwindSafe,
    metadata: impl Wire2Api<Metadata> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "write_metadata",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file = file.wire2api();
            let api_metadata = metadata.wire2api();
            move |task_callback| write_metadata(api_file, api_metadata)
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<f64> for f64 {
    fn wire2api(self) -> f64 {
        self
    }
}
impl Wire2Api<i32> for i32 {
    fn wire2api(self) -> i32 {
        self
    }
}

impl Wire2Api<u16> for u16 {
    fn wire2api(self) -> u16 {
        self
    }
}
impl Wire2Api<u64> for u64 {
    fn wire2api(self) -> u64 {
        self
    }
}
impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

// Section: impl IntoDart

impl support::IntoDart for Metadata {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.title.into_dart(),
            self.duration_ms.into_dart(),
            self.artist.into_dart(),
            self.album.into_dart(),
            self.album_artist.into_dart(),
            self.track_number.into_dart(),
            self.track_total.into_dart(),
            self.disc_number.into_dart(),
            self.disc_total.into_dart(),
            self.year.into_dart(),
            self.genre.into_dart(),
            self.picture.into_dart(),
            self.file_size.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Metadata {}

impl support::IntoDart for Picture {
    fn into_dart(self) -> support::DartAbi {
        vec![self.mime_type.into_dart(), self.data.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Picture {}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

/// cbindgen:ignore
#[cfg(target_family = "wasm")]
mod web {
    use super::*;
    // Section: wire functions

    #[wasm_bindgen]
    pub fn wire_read_metadata(port_: MessagePort, file: String) {
        wire_read_metadata_impl(port_, file)
    }

    #[wasm_bindgen]
    pub fn wire_write_metadata(port_: MessagePort, file: String, metadata: JsValue) {
        wire_write_metadata_impl(port_, file, metadata)
    }

    // Section: allocate functions

    // Section: related functions

    // Section: impl Wire2Api

    impl Wire2Api<String> for String {
        fn wire2api(self) -> String {
            self
        }
    }

    impl Wire2Api<Metadata> for JsValue {
        fn wire2api(self) -> Metadata {
            let self_ = self.dyn_into::<JsArray>().unwrap();
            assert_eq!(
                self_.length(),
                13,
                "Expected 13 elements, got {}",
                self_.length()
            );
            Metadata {
                title: self_.get(0).wire2api(),
                duration_ms: self_.get(1).wire2api(),
                artist: self_.get(2).wire2api(),
                album: self_.get(3).wire2api(),
                album_artist: self_.get(4).wire2api(),
                track_number: self_.get(5).wire2api(),
                track_total: self_.get(6).wire2api(),
                disc_number: self_.get(7).wire2api(),
                disc_total: self_.get(8).wire2api(),
                year: self_.get(9).wire2api(),
                genre: self_.get(10).wire2api(),
                picture: self_.get(11).wire2api(),
                file_size: self_.get(12).wire2api(),
            }
        }
    }
    impl Wire2Api<Option<String>> for Option<String> {
        fn wire2api(self) -> Option<String> {
            self.map(Wire2Api::wire2api)
        }
    }

    impl Wire2Api<Option<Picture>> for JsValue {
        fn wire2api(self) -> Option<Picture> {
            (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
        }
    }

    impl Wire2Api<Picture> for JsValue {
        fn wire2api(self) -> Picture {
            let self_ = self.dyn_into::<JsArray>().unwrap();
            assert_eq!(
                self_.length(),
                2,
                "Expected 2 elements, got {}",
                self_.length()
            );
            Picture {
                mime_type: self_.get(0).wire2api(),
                data: self_.get(1).wire2api(),
            }
        }
    }

    impl Wire2Api<Vec<u8>> for Box<[u8]> {
        fn wire2api(self) -> Vec<u8> {
            self.into_vec()
        }
    }
    // Section: impl Wire2Api for JsValue

    impl Wire2Api<String> for JsValue {
        fn wire2api(self) -> String {
            self.as_string().expect("non-UTF-8 string, or not a string")
        }
    }
    impl Wire2Api<f64> for JsValue {
        fn wire2api(self) -> f64 {
            self.unchecked_into_f64() as _
        }
    }
    impl Wire2Api<i32> for JsValue {
        fn wire2api(self) -> i32 {
            self.unchecked_into_f64() as _
        }
    }
    impl Wire2Api<Option<String>> for JsValue {
        fn wire2api(self) -> Option<String> {
            (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
        }
    }
    impl Wire2Api<Option<f64>> for JsValue {
        fn wire2api(self) -> Option<f64> {
            (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
        }
    }
    impl Wire2Api<Option<i32>> for JsValue {
        fn wire2api(self) -> Option<i32> {
            (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
        }
    }
    impl Wire2Api<Option<u16>> for JsValue {
        fn wire2api(self) -> Option<u16> {
            (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
        }
    }
    impl Wire2Api<Option<u64>> for JsValue {
        fn wire2api(self) -> Option<u64> {
            (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
        }
    }
    impl Wire2Api<u16> for JsValue {
        fn wire2api(self) -> u16 {
            self.unchecked_into_f64() as _
        }
    }
    impl Wire2Api<u64> for JsValue {
        fn wire2api(self) -> u64 {
            ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
        }
    }
    impl Wire2Api<u8> for JsValue {
        fn wire2api(self) -> u8 {
            self.unchecked_into_f64() as _
        }
    }
    impl Wire2Api<Vec<u8>> for JsValue {
        fn wire2api(self) -> Vec<u8> {
            self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
        }
    }
}
#[cfg(target_family = "wasm")]
pub use web::*;

#[cfg(not(target_family = "wasm"))]
mod io {
    use super::*;
    // Section: wire functions

    #[no_mangle]
    pub extern "C" fn wire_read_metadata(port_: i64, file: *mut wire_uint_8_list) {
        wire_read_metadata_impl(port_, file)
    }

    #[no_mangle]
    pub extern "C" fn wire_write_metadata(
        port_: i64,
        file: *mut wire_uint_8_list,
        metadata: *mut wire_Metadata,
    ) {
        wire_write_metadata_impl(port_, file, metadata)
    }

    // Section: allocate functions

    #[no_mangle]
    pub extern "C" fn new_box_autoadd_f64_0(value: f64) -> *mut f64 {
        support::new_leak_box_ptr(value)
    }

    #[no_mangle]
    pub extern "C" fn new_box_autoadd_i32_0(value: i32) -> *mut i32 {
        support::new_leak_box_ptr(value)
    }

    #[no_mangle]
    pub extern "C" fn new_box_autoadd_metadata_0() -> *mut wire_Metadata {
        support::new_leak_box_ptr(wire_Metadata::new_with_null_ptr())
    }

    #[no_mangle]
    pub extern "C" fn new_box_autoadd_picture_0() -> *mut wire_Picture {
        support::new_leak_box_ptr(wire_Picture::new_with_null_ptr())
    }

    #[no_mangle]
    pub extern "C" fn new_box_autoadd_u16_0(value: u16) -> *mut u16 {
        support::new_leak_box_ptr(value)
    }

    #[no_mangle]
    pub extern "C" fn new_box_autoadd_u64_0(value: u64) -> *mut u64 {
        support::new_leak_box_ptr(value)
    }

    #[no_mangle]
    pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
        let ans = wire_uint_8_list {
            ptr: support::new_leak_vec_ptr(Default::default(), len),
            len,
        };
        support::new_leak_box_ptr(ans)
    }

    // Section: related functions

    // Section: impl Wire2Api

    impl Wire2Api<String> for *mut wire_uint_8_list {
        fn wire2api(self) -> String {
            let vec: Vec<u8> = self.wire2api();
            String::from_utf8_lossy(&vec).into_owned()
        }
    }
    impl Wire2Api<f64> for *mut f64 {
        fn wire2api(self) -> f64 {
            unsafe { *support::box_from_leak_ptr(self) }
        }
    }
    impl Wire2Api<i32> for *mut i32 {
        fn wire2api(self) -> i32 {
            unsafe { *support::box_from_leak_ptr(self) }
        }
    }
    impl Wire2Api<Metadata> for *mut wire_Metadata {
        fn wire2api(self) -> Metadata {
            let wrap = unsafe { support::box_from_leak_ptr(self) };
            Wire2Api::<Metadata>::wire2api(*wrap).into()
        }
    }
    impl Wire2Api<Picture> for *mut wire_Picture {
        fn wire2api(self) -> Picture {
            let wrap = unsafe { support::box_from_leak_ptr(self) };
            Wire2Api::<Picture>::wire2api(*wrap).into()
        }
    }
    impl Wire2Api<u16> for *mut u16 {
        fn wire2api(self) -> u16 {
            unsafe { *support::box_from_leak_ptr(self) }
        }
    }
    impl Wire2Api<u64> for *mut u64 {
        fn wire2api(self) -> u64 {
            unsafe { *support::box_from_leak_ptr(self) }
        }
    }

    impl Wire2Api<Metadata> for wire_Metadata {
        fn wire2api(self) -> Metadata {
            Metadata {
                title: self.title.wire2api(),
                duration_ms: self.duration_ms.wire2api(),
                artist: self.artist.wire2api(),
                album: self.album.wire2api(),
                album_artist: self.album_artist.wire2api(),
                track_number: self.track_number.wire2api(),
                track_total: self.track_total.wire2api(),
                disc_number: self.disc_number.wire2api(),
                disc_total: self.disc_total.wire2api(),
                year: self.year.wire2api(),
                genre: self.genre.wire2api(),
                picture: self.picture.wire2api(),
                file_size: self.file_size.wire2api(),
            }
        }
    }

    impl Wire2Api<Picture> for wire_Picture {
        fn wire2api(self) -> Picture {
            Picture {
                mime_type: self.mime_type.wire2api(),
                data: self.data.wire2api(),
            }
        }
    }

    impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
        fn wire2api(self) -> Vec<u8> {
            unsafe {
                let wrap = support::box_from_leak_ptr(self);
                support::vec_from_leak_ptr(wrap.ptr, wrap.len)
            }
        }
    }
    // Section: wire structs

    #[repr(C)]
    #[derive(Clone)]
    pub struct wire_Metadata {
        title: *mut wire_uint_8_list,
        duration_ms: *mut f64,
        artist: *mut wire_uint_8_list,
        album: *mut wire_uint_8_list,
        album_artist: *mut wire_uint_8_list,
        track_number: *mut u16,
        track_total: *mut u16,
        disc_number: *mut u16,
        disc_total: *mut u16,
        year: *mut i32,
        genre: *mut wire_uint_8_list,
        picture: *mut wire_Picture,
        file_size: *mut u64,
    }

    #[repr(C)]
    #[derive(Clone)]
    pub struct wire_Picture {
        mime_type: *mut wire_uint_8_list,
        data: *mut wire_uint_8_list,
    }

    #[repr(C)]
    #[derive(Clone)]
    pub struct wire_uint_8_list {
        ptr: *mut u8,
        len: i32,
    }

    // Section: impl NewWithNullPtr

    pub trait NewWithNullPtr {
        fn new_with_null_ptr() -> Self;
    }

    impl<T> NewWithNullPtr for *mut T {
        fn new_with_null_ptr() -> Self {
            std::ptr::null_mut()
        }
    }

    impl NewWithNullPtr for wire_Metadata {
        fn new_with_null_ptr() -> Self {
            Self {
                title: core::ptr::null_mut(),
                duration_ms: core::ptr::null_mut(),
                artist: core::ptr::null_mut(),
                album: core::ptr::null_mut(),
                album_artist: core::ptr::null_mut(),
                track_number: core::ptr::null_mut(),
                track_total: core::ptr::null_mut(),
                disc_number: core::ptr::null_mut(),
                disc_total: core::ptr::null_mut(),
                year: core::ptr::null_mut(),
                genre: core::ptr::null_mut(),
                picture: core::ptr::null_mut(),
                file_size: core::ptr::null_mut(),
            }
        }
    }

    impl Default for wire_Metadata {
        fn default() -> Self {
            Self::new_with_null_ptr()
        }
    }

    impl NewWithNullPtr for wire_Picture {
        fn new_with_null_ptr() -> Self {
            Self {
                mime_type: core::ptr::null_mut(),
                data: core::ptr::null_mut(),
            }
        }
    }

    impl Default for wire_Picture {
        fn default() -> Self {
            Self::new_with_null_ptr()
        }
    }

    // Section: sync execution mode utility

    #[no_mangle]
    pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
        unsafe {
            let _ = support::box_from_leak_ptr(ptr);
        };
    }
}
#[cfg(not(target_family = "wasm"))]
pub use io::*;
