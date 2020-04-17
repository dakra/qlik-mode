;;; qlik-mode.el --- Major mode for editing QlikView (QVS) files  -*- lexical-binding: t -*-

;; Copyright (c) 2020 Daniel Kraus <daniel@kraus.my>

;; Author: Daniel Kraus <daniel@kraus.my>
;; URL: https://github.com/dakra/qlik-mode.el
;; Keywords: languages qlik qlikview qvs
;; Version: 0.1
;; Package-Requires: ((emacs "25.2"))

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Major mode for editing QlikView (QVS) files.
;; FIXME: Everything.  Only basic font-lock implemented yet.

;;; Code:

(require 'sql)

(defun qlik-imenu-setup ()
  "Setup imenu for qlik-mode."
  (add-to-list 'imenu-generic-expression '("Tabs" "\\(^//.*$tab +\\)\\(\\_<.+\\_>\\)" 2)))

(defvar qlik-built-in
  '("Acos" "Addmonths" "Addyears" "Age" "Alt" "Applycodepage" "Applymap" "Argb" "Asin" "Atan" "Atan2" "Attribute" "Author" "Autonumber"
    "Autonumberhash128" "Autonumberhash256" "Avg" "Bitcount" "Black" "Blackandschole" "Blue" "Brown" "Capitalize" "Ceil" "Chi2test_chi2"
    "Chi2test_df" "Chi2test_p" "Chidist" "Chiinv" "Chr" "Class" "Clientplatform" "Color" "Colormaphue" "Colormapjet" "Colormix1" "Colormix2"
    "Combin" "Computername" "Concat" "Connectstring" "Converttolocaltime" "Correl" "Cos" "Cosh" "Count" "Cyan" "Darkgray" "Day" "Dayend"
    "Daylightsaving" "Dayname" "Daynumberofquarter" "Daynumberofyear" "Daystart" "Div" "DocumentName" "DocumentPath" "DocumentTitle" "Dual"
    "E" "Evaluate" "Even" "Exists" "Exp" "Fabs" "Fact" "False" "Fdist" "FieldIndex" "FieldName" "FieldNumber" "FieldValue" "FieldValueCount"
    "FileBaseName" "FileDir" "FileExtension" "FileList" "FileName" "FilePath" "FileSize" "FileTime" "FindOneOf" "Finv" "FirstSortedValue"
    "FirstValue" "FirstWorkDate" "Floor" "Fmod" "Frac" "Fractile" "Fv" "GetExtendedProperty" "GetFolderPath" "GetObjectField"
    "GetRegistryString" "GMT" "Green" "Hash128" "Hash160" "Hash256" "Hour" "HSL" "InDay" "InDayToTime" "Index" "InLunarWeek"
    "InLunarWeekToDate" "InMonth" "InMonths" "InMonthsToDate" "InMonthToDate" "Input" "InputAvg" "InputSum" "InQuarter"
    "InQuarterToDate" "Interval" "Interval#" "InWeek" "InWeekToDate" "InYear" "InYearToDate" "IRR" "IsNull" "IsNum"
    "IsPartialReload" "IsText" "IterNo" "KeepChar" "Kurtosis" "LastValue" "LastWorkDate" "Len" "LightBlue" "LightCyan"
    "LightGray" "LightGreen" "LightMagenta" "LightRed" "LINEST_B" "LINEST_DF" "LINEST_F" "LINEST_M" "LINEST_R2" "LINEST_SEB" "LINEST_SEM"
    "LINEST_SEY" "LINEST_SSREG" "LINEST_SSRESID" "LocalTime" "log" "log10" "Lookup" "Lower" "LTrim" "LunarWeekEnd" "LunarWeekName"
    "LunarWeekStart" "Magenta" "MakeDate" "MakeTime" "MakeWeekDate" "MapSubString" "Match" "Max" "MaxString" "Median" "Mid" "Min" "MinString"
    "Minute" "MissingCount" "MixMatch" "Mod" "Mode" "Money" "Money#" "Month"
    "MonthEnd" "MonthName" "MonthsEnd" "MonthsName" "MonthsStart" "MonthStart" "MsgBox" "NetWorkDays" "NoOfFields" "NoOfReports" "NoOfRows"
    "NoOfTables" "NORMDIST" "NORMINV" "Now" "nPer" "NPV" "Null" "NullCount" "Num" "Num" "NumAvg" "NumCount" "NumericCount" "NumMax" "NumMin"
    "NumSum" "Odd" "Only" "Ord" "OSUser" "Peek" "Permut" "Pi" "Pick" "Pmt" "pow" "Previous" "PurgeChar" "PV" "QlikTechBlue" "QlikTechGray"
    "QlikViewVersion" "QuarterEnd" "QuarterName" "QuarterStart" "QvdCreateTime" "QvdFieldName" "QvdNoOfFields" "QvdNoOfRecords" "QvdTableName"
    "QVUser" "Rand" "RangeAvg" "RangeCorrel"
    "RangeCount" "RangeFractile" "RangeIRR" "RangeKurtosis" "RangeMax" "RangeMaxString" "RangeMin" "RangeMinString" "RangeMissingCount"
    "RangeMode" "RangeNPV" "RangeNullCount" "RangeNumericCount" "RangeOnly" "RangeSkew" "RangeStdev" "RangeSum" "RangeTextCount" "RangeXIRR"
    "RangeXNPV" "Rate" "RecNo" "Red" "ReloadTime" "Repeat" "Replace" "ReportComment" "ReportId" "ReportName" "ReportNumber" "RGB" "Round"
    "RowNo" "RTrim" "Second" "SetDateYear" "SetDateYearMonth" "Sign" "sin" "sinh" "Skew" "sqr" "sqrt" "Stdev" "Sterr" "STEYX" "SubField|10"
    "SubStringCount" "Sum" "SysColor" "TableName" "TableNumber" "tan" "tanh" "TDIST" "Text" "TextBetween" "TextCount" "TimeZone" "TINV" "Today"
    "Trim" "True" "TTest1_conf" "TTest1_df" "TTest1_dif" "TTest1_lower" "TTest1_sig" "TTest1_sterr" "TTest1_t" "TTest1_upper" "TTest1w_conf"
    "TTest1w_df" "TTest1w_dif" "TTest1w_lower" "TTest1w_sig" "TTest1w_sterr" "TTest1w_t" "TTest1w_upper" "TTest_conf" "TTest_df" "TTest_dif"
    "TTest_lower" "TTest_sig" "TTest_sterr" "TTest_t" "TTest_upper" "TTestw_conf" "TTestw_df" "TTestw_dif" "TTestw_lower" "TTestw_sig"
    "TTestw_sterr" "TTestw_t" "TTestw_upper" "Upper" "UTC" "Week" "WeekDay" "WeekEnd" "WeekName" "WeekStart" "WeekYear" "White" "WildMatch"
    "WildMatch5" "XIRR" "XNPV" "Year" "Year2Date" "YearEnd" "YearName" "YearStart" "YearToDate" "Yellow" "ZTest_conf" "ZTest_dif" "ZTest_lower"
    "ZTest_sig" "ZTest_sterr" "ZTest_upper" "ZTest_z" "ZTestw_conf" "ZTestw_dif" "ZTestw_lower" "ZTestw_sig" "ZTestw_sterr" "ZTestw_upper" "ZTestw_z"))

(defvar qlik-highlights
  `(("^\\s-*\\_<\\([[:alnum:]]\\|_\\)*\\_>:" . font-lock-function-name-face)
    ("^\\s-*//.*\\($tab +\\_<.+\\_>\\)"  . (1 font-lock-reference-face))
    ("^\\s-*//.*" . font-lock-comment-face)
    (,(regexp-opt qlik-built-in 'words) . font-lock-builtin-face)
    (,(regexp-opt '("let" "set" "Integer" "Integer64" "Number" "Decimal" "DecimalFloat" "Double"
                    "UUID" "String" "LargeString" "Boolean" "Binary" "LargeBinary"
                    "Date" "Time" "DateTime" "Timestamp") 'words) . font-lock-type-face)))

(defvar qlik-font-lock-highlights
  (append qlik-highlights
          (sql-get-product-feature 'ansi :font-lock)
          (list sql-mode-font-lock-object-name))
  "Font lock highlights is qlik specia stuff plus SQL.")

;;;###autoload
(define-derived-mode qlik-mode prog-mode "qlik"
  "Major mode for editing QlikView (QVS) files."
  (setq font-lock-defaults '(qlik-font-lock-highlights nil t))

  (set (make-local-variable 'tab-width) 4)
  (set (make-local-variable 'indent-tabs-mode) nil)

  (set (make-local-variable 'comment-start) "// ")
  (set (make-local-variable 'comment-start-skip) "//+\\s-*")

  (qlik-imenu-setup))

;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.\\(qlik\\|qvs\\)\\'" #'qlik-mode))

(provide 'qlik-mode)
;;; qlik-mode.el ends here
