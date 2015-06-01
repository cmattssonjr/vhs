Name:           vhs
Version:        2.2
Release:        6%{?dist}
Summary:        Video Handler Script, using ffmpeg

License:        GPLv3
URL:            https://github.com/sri-arjuna/vhs
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
Requires:       tui
Requires:       ffmpeg
Requires:       mkvtoolnix
Requires:       v4l-utils
Requires:       vobcopy
# gstreamer1 gstreamer1-plugins-{good,bad-free,ugly,base} gstreamer1-plugins-{base-tools,good-extras,bad-freeworld} faac
# 

# Not yet there, need to write handler for these,
#   if i'm going to implement (need) all this
#Requires:       ogmtools
#Requires:       oggvideotools
#Requires:       theora-tools
#Requires:       vorbis-tools
#Requires:       speex-tools
#Requires:       swftools
#Requires:       mjpegtools

%description
A Script to handle many different multimedia tasks.
* Re-encode existing videos
* Capture web cam
* Capture desktop
* Capture webcam as PiP over desktop
* Extract audio stream from video files
* Include audio-, subtitle streams
* Include PiP Video
* Include Logoimage (Top Left fixed)
* Encode DVD
* Streaming / server

%prep
%setup -q -c %{name}-%{version}

%build
# Nothing to do

%install
rm -rf $RPM_BUILD_ROOT
##%make_install

mkdir -p %{buildroot}%{_bindir}/ \
         %{buildroot}%{_datarootdir}/%{name} \
	 %{buildroot}%{_mandir}/man1 \
	 %{buildroot}%{_sysconfdir}/bash_completion.d/
rm -fr %{name}/.git
mv %{name}/files/vhs.sh %{buildroot}%{_bindir}/vhs
mv %{name}/files/vhs.1      %{buildroot}%{_mandir}/man1
mv %{name}/files/%{name}_compl.bash %{buildroot}%{_sysconfdir}/bash_completion.d/
mv %{name}/docs/[ILR]*  %{buildroot}%{_datarootdir}/%{name}

%files
%doc %{_datarootdir}/%{name}/README.md 
%doc %{_datarootdir}/%{name}/INSTALL.md 
%doc %{_datarootdir}/%{name}/LICENSE
%{_sysconfdir}/bash_completion.d/%{name}*
%{_mandir}/man1/%{name}*.1.gz
%{_bindir}/vhs

%changelog
* Mon Jun 1 2015 Simon A. Erat <erat.simon@gmail.com> 2.2
- Fixed:   Some files (audio streams) could not be identfied
-          on systems with non-english locales.
- Updated: Playmode now shows progressbar for files
- Changed: Several stream checks got messed up because of PlayStatus

* Sun May 17 2015 Simon A. Erat <erat.simon@gmail.com> 2.2
- Changed: Some temp file variable names
- Fixed:   Outputfile name when exporting audio
- Fixed:   When encoding videos, progressbar should match now
- Updated: Selection of playstreams should now match terminal width

* Thu Apr 09 2015 Simon A. Erat <erat.simon@gmail.com> 2.1
- Added:   Bit Calculator, vhs calc
- Added:   Ip lister, vhs ip
- Changed: Rearanged project files
- Changed: README.md
- Added:   INSTALL.md & install.sh
- Fixed:   Audio extraction using the passed codec again


* Sun Mar 29 2015 Simon A. Erat <erat.simon@gmail.com> 2.0
- Added:   Stream Play
- Added:   Stream Server, Webcam, Screen, Guide, Video
- Added:   History re-select for Stream Play/Serve individualy
- Updated: Now can encode multiple files to audio

* Fri Mar 27 2015 Simon A. Erat <erat.simon@gmail.com> 1.3.5
- Updated: corrected filesize calculation
- Updated: during verbose ffmpeg progress bar is no longer shown
- Updated: Now can change volume
- Updated: Now can merge/join/append video files.
- Updated: Now uses a single file to handle all containers

* Wed Mar 25 2015 Simon A. Erat <erat.simon@gmail.com> 1.3.4
- Updated: Encoding videos show now a progress bar

* Tue Mar 10 2015 Simon A. Erat <erat.simon@gmail.com> 1.3.4
- Updated: DVD: Encoding no longer stops after vobcopy, ty Robert.
- Fixed:   DVD: Audio selection menu, tried to include stream 'done'
- Updated: DVD: Vobcopy offers alternative copy ways, 
-                 only use if default fails!
- Updated: DVD: Vobcopy using specific title works now.
- Updated: presets
-            -now calculates the expected 1 min filesize
-            -when adding ntsc & pal, helpoutput gets cut
- Updated: Removed some commented out lines

* Sat Mar 07 2015 Simon A. Erat <erat.simon@gmail.com> 1.3.3
- Updated: Encoded-by information is no longer in the description
- Updated: To copy (only) subtitle codecs, use: '-c tcopy'
-          previous it was 'scopy'
- Fixed:   Issue with reading attachmet ids
- Updated: The '-j' toggle now includes ALL attachments (Fonts, etc)
- Added:   Finaly added a manpage.

* Thu Feb 26 2015 Simon A. Erat <erat.simon@gmail.com> 1.3.2
- Updated: Bash completition reads now the qualtiy from file
- Updated: Screenrecording now takes quality argument

* Tue Feb 17 2015 Simon A. Erat <erat.simon@gmail.com> 1.3.1
- Updated: Default preset video bitrates increased
-          This should improve first time experience drasticly
-          for the visual oriented enduser
- Updated: Japan is pushing 8k, vhs is prepared
- Fixed:   Overwrote existing XDG_VIDEOS_DIR variable
- Added:   Anime and Youtube presets

* Wed Feb 11 2015 Simon A. Erat <erat.simon@gmail.com> 1.3
- Updated: Presets are now stored in a file
- Updated: bash completion for dynamic readout
- Updated: Guide-, Screen- and Webcam videos
-            are now stored in $XDG_VIDEOS_DIR (~/Videos)
- Fixed:   Failure on ISO streams
- Fixed:   Audio selection if none could be recognized

* Thu Jan 08 2015 Simon A. Erat <erat.simon@gmail.com> 1.2.3
- Using now vobcopy to copy vob files from dvd
- Partly implemented tui-select

* Mon Dec 08 2014 Simon A. Erat <erat.simon@gmail.com> 1.1.1
- Updated bash completition
- Fixed a tempdir path issue

* Sat Nov 29 2014 Simon A. Erat <erat.simon@gmail.com> 1.1.0
- Added bash completition

* Sat Nov 15 2014 Simon A. Erat <erat.simon@gmail.com> 1.0.9
- Fixed tui-value-* errors
- Added '-A' toggle to edit command before executing
- new old bug: webm... idk why...

* Tue Nov 04 2014 Simon A. Erat <erat.simon@gmail.com> 1.0.7
- Reducded -Q dvd from v768 to v640
- Re-sadded 2pass encoding: -2
- Fixed small typos

* Tue Nov 04 2014 Simon A. Erat <erat.simon@gmail.com> 1.0.6
- Increased -Q dvd from v640 to v768

* Fri Oct 24 2014 Simon A. Erat <erat.simon@gmail.com> 1.0.5
- Updated description

* Mon Oct 20 2014 Simon A. Erat <erat.simon@gmail.com> 1.0.4
- Initial package
