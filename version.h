#ifndef ISPP_INVOKED
/*
 * 你可以在这个头文件里定义你的项目的详细信息
 * Inno Setup 会自动读取此文件并使用其所需的相关信息
 */
#endif

#ifndef EX_VERSION_H
#define EX_VERSION_H

#ifndef _T
#if !defined(ISPP_INVOKED) && (defined(UNICODE) || defined(_UNICODE))
#define _T(text) L##text
#else
#define _T(text) text
#endif
#endif

#define EX_VERSION_MAJOR 1
#define EX_VERSION_MINOR 0
#define EX_VERSION_PATCH 0
#define EX_VERSION_BUILD 0
#ifndef ISPP_INVOKED
#define EX_VERSION_NUM          EX_VERSION_MAJOR,EX_VERSION_MINOR,EX_VERSION_PATCH,EX_VERSION_BUILD
#define EX_VERSION_STR          _T("1.0.0.0")
#endif

#define EX_APP_ID_32_STR        _T("{BC3D821C-7EFA-41F8-B1C2-8A55DDFE5A67}")
#define EX_APP_ID_64_STR        _T("{B74B8C7D-C21A-41B1-B419-9D63B484EEF4}")
#define EX_APP_NAME_STR         _T("My Application")
#define EX_APP_DISPLAY_NAME_STR _T("My Test Application")
#define EX_APP_MUTEX_32_STR     EX_APP_ID_32_STR
#define EX_APP_MUTEX_64_STR     EX_APP_ID_64_STR
#define EX_COMPANY_NAME_STR     _T("wangwenx190")
#define EX_COMPANY_URL_STR      _T("http://www.example.com/")
#define EX_SUPPORT_URL_STR      EX_COMPANY_URL_STR
#define EX_UPDATE_URL_STR       EX_COMPANY_URL_STR
#define EX_CONTACT_STR          EX_COMPANY_NAME_STR
#define EX_SUPPORT_PHONE_STR    _T("10010001000")
#define EX_README_URL_STR       _T("https://github.com/wangwenx190/installer/blob/master/README.md")
#define EX_LICENSE_URL_STR      _T("https://github.com/wangwenx190/installer/blob/master/LICENSE")
#define EX_COMMENTS_STR         _T("Comments")
#define EX_COPYRIGHT_STR        _T("Unlicense.")

#ifdef _WIN64
#define EX_APP_ID_STR           EX_APP_ID_64_STR
#define EX_APP_MUTEX_STR        EX_APP_MUTEX_64_STR
#else
#define EX_APP_ID_STR           EX_APP_ID_32_STR
#define EX_APP_MUTEX_STR        EX_APP_MUTEX_32_STR
#endif

#endif
