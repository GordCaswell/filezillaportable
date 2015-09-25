!macro CustomCodePreInstall
	${If} ${FileExists} "$INSTDIR\App\AppInfo\appinfo.ini"
		ReadINIStr $0 "$INSTDIR\App\AppInfo\appinfo.ini" "Version" "PackageVersion"
		${VersionCompare} $0 "3.14.0.1" $1
		${If} $1 == 2 ;Upgrading from version before 3.14.0.1
		${AndIf} ${FileExists} "$INSTDIR\Data\settings\filezilla.xml"
			${ConfigWrite} '$INSTDIR\Data\settings\filezilla.xml' '        <Setting name="Language Code" type="string" /' 'Setting' $R0
			${ConfigWrite} '$INSTDIR\Data\settings\filezilla.xml' '        <Setting name="Language Code" type="string"' '>' $R0
		${EndIf}
	${EndIf}
!macroend

!macro CustomCodePostInstall
	${If} ${FileExists} "$INSTDIR\Data\settings\filezilla.xml"
	${AndIfNot} ${FileExists} "$INSTDIR\Data\settings\filezilla-putty.reg"
		CopyFiles /SILENT "$INSTDIR\App\DefaultData\settings\filezilla-putty.reg" "$INSTDIR\Data\settings"
	${EndIf}
!macroend