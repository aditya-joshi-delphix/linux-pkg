#!/usr/bin/env bash
# Copyright 2021 Delphix
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# shellcheck disable=SC2034

DEFAULT_PACKAGE_GIT_URL=none
DEFAULT_PACKAGE_VERSION="1.0.0"

_tarfile_sha256_linux="71a20f823ff7df646b5b8503e59b1c7515b57f2812f0121142c4fc87ddcca5e6"
_tarfile_sha256_linux_172="c8544a44c946aa971450e18bfa02a0741a986afd3d30c70ded2ea86c9743dac0"
_tarfile_sha256_linux_ppc64le="ed5cbc0f292abf68923720fa2bd76aab63a0cd92e6d8145f30a4d10135bb8ec3"
_tarfile_sha256_aix="545695b4763117225f7b38e628e519d3c54063eed59cbafd189a2c9d57724686"
_tarfile_sha256_hpux="6f601c0cd8367fd5a4e2aead840fcdd5e9e28d73b704d040573149940779651f"
_tarfile_sha256_solaris_x86="5f66e95e784d6ca36ccabab45719413e930db50d436aa123779bc2fce389742a"
_tarfile_sha256_solaris_sparc="404879c9df52b79652b1e1534e74d0aac90423c6b5efdcb79e44c34cc9f1211c"
_tarfile_sha256_windows="2c02b3d5c69165f636ca9123eddbc641ecdf512807575283cbf433991caeb03a"
_artifactory_java_packages_url="https://artifactory.delphix.com/artifactory/delphix-java-packages"
function fetch() {
	# fetch all the host jdk tarfiles from artifactory
	logmust cp -r "$PKGDIR/code" "$WORKDIR/repo"
	local url_linux="$_artifactory_java_packages_url/linux/jdk1.8/OpenJDK8U-jdk_x64_linux_hotspot_8u262b10.tar.gz"
	local url_linux_jdk_8_172="$_artifactory_java_packages_url/linux/jdk1.8/OpenJDK8_x64_Linux_jdk8u172-b11.tar.gz"
	local url_linux_ppc64le="$_artifactory_java_packages_url/linux/jdk1.8/OpenJDK8U-jdk_ppc64le_linux_hotspot_8u262b10.tar.gz"
	local url_aix="$_artifactory_java_packages_url/aix/jdk1.8/jdk-8.0.0.611-aix-powerpc64.tar.gz"
	local url_hpux="$_artifactory_java_packages_url/hpux/jdk1.8/jdk-8.0.20-hpux-ia64.tar.gz"
	local url_solaris_x86="$_artifactory_java_packages_url/sunos/jdk1.8/OpenJDK8U-jdk_x64_solaris_hotspot_8u262b10.tar.gz"
	local url_solaris_sparc="$_artifactory_java_packages_url/sunos/jdk1.8/OpenJDK8U-jdk_sparcv9_solaris_hotspot_8u262b10.tar.gz"
	local url_windows="$_artifactory_java_packages_url/windows/jdk1.8/OpenJDK8U-jdk_x64_windows_hotspot_8u262b10.zip"
	logmust cd "$WORKDIR/repo"
	logmust fetch_file_from_artifactory "$url_linux" "$_tarfile_sha256_linux"
	logmust fetch_file_from_artifactory "$url_linux_jdk_8_172" "$_tarfile_sha256_linux_172"
	logmust fetch_file_from_artifactory "$url_linux_ppc64le" "$_tarfile_sha256_linux_ppc64le"
	logmust fetch_file_from_artifactory "$url_aix" "$_tarfile_sha256_aix"
	logmust fetch_file_from_artifactory "$url_hpux" "$_tarfile_sha256_hpux"
	logmust fetch_file_from_artifactory "$url_solaris_x86" "$_tarfile_sha256_solaris_x86"
	logmust fetch_file_from_artifactory "$url_solaris_sparc" "$_tarfile_sha256_solaris_sparc"
	logmust fetch_file_from_artifactory "$url_windows" "$_tarfile_sha256_windows"
}

function build() {
	logmust mkdir -p "$WORKDIR/repo"
	logmust dpkg_buildpackage_default
}
