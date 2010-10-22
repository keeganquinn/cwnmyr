# $Id: service_apache.rb 2687 2006-05-31 06:22:48Z keegan $
# Copyright 2006 Keegan Quinn
#
# Apache webserver configuration script.
#
# This is used as a plugin by ahservices.
#
#--
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#++

def configure_service(node, host, interfaces, properties)
  # Construct /etc/apache/httpd.conf
  httpd_conf_file = sprintf("ServerType standalone\n")
  httpd_conf_file += sprintf("ServerRoot /etc/apache\n")
  httpd_conf_file += sprintf("LockFile /var/lock/apache.lock\n")
  httpd_conf_file += sprintf("PidFile /var/run/apache.pid\n")
  httpd_conf_file += sprintf("ScoreBoardFile /var/run/apache.scoreboard\n")
  httpd_conf_file += sprintf("Timeout 300\n")
  httpd_conf_file += sprintf("KeepAlive on\n")
  httpd_conf_file += sprintf("MaxKeepAliveRequests 100\n")
  httpd_conf_file += sprintf("KeepAliveTimeout 15\n")
  httpd_conf_file += sprintf("MinSpareServers 5\n")
  httpd_conf_file += sprintf("MaxSpareServers 10\n")
  httpd_conf_file += sprintf("StartServers 5\n")
  httpd_conf_file += sprintf("MaxClients 150\n")
  httpd_conf_file += sprintf("MaxRequestsPerChild 100\n\n")

  httpd_conf_file += sprintf("# Please keep this LoadModule: line here, " +
                               "it is needed for installation.\n")
  httpd_conf_file += sprintf("LoadModule config_log_module " +
                               "/usr/lib/apache/1.3/mod_log_config.so\n")
  httpd_conf_file += sprintf("LoadModule mime_magic_module " +
                               "/usr/lib/apache/1.3/mod_mime_magic.so\n")
  httpd_conf_file += sprintf("LoadModule mime_module " +
                               "/usr/lib/apache/1.3/mod_mime.so\n")
  httpd_conf_file += sprintf("LoadModule negotiation_module " +
                               "/usr/lib/apache/1.3/mod_negotiation.so\n")
  httpd_conf_file += sprintf("LoadModule status_module " +
                               "/usr/lib/apache/1.3/mod_status.so\n")
  httpd_conf_file += sprintf("LoadModule autoindex_module " +
                               "/usr/lib/apache/1.3/mod_autoindex.so\n")
  httpd_conf_file += sprintf("LoadModule dir_module " +
                               "/usr/lib/apache/1.3/mod_dir.so\n")
  httpd_conf_file += sprintf("LoadModule cgi_module " +
                               "/usr/lib/apache/1.3/mod_cgi.so\n")
  httpd_conf_file += sprintf("LoadModule userdir_module " +
                               "/usr/lib/apache/1.3/mod_userdir.so\n")
  httpd_conf_file += sprintf("LoadModule alias_module " +
                               "/usr/lib/apache/1.3/mod_alias.so\n")
  httpd_conf_file += sprintf("LoadModule rewrite_module " +
                               "/usr/lib/apache/1.3/mod_rewrite.so\n")
  httpd_conf_file += sprintf("LoadModule access_module " +
                               "/usr/lib/apache/1.3/mod_access.so\n")
  httpd_conf_file += sprintf("LoadModule auth_module " +
                               "/usr/lib/apache/1.3/mod_auth.so\n")
  httpd_conf_file += sprintf("LoadModule expires_module " +
                               "/usr/lib/apache/1.3/mod_expires.so\n")
  httpd_conf_file += sprintf("LoadModule unique_id_module " +
                               "/usr/lib/apache/1.3/mod_unique_id.so\n")
  httpd_conf_file += sprintf("LoadModule setenvif_module " +
                               "/usr/lib/apache/1.3/mod_setenvif.so\n\n")

  httpd_conf_file += sprintf("ExtendedStatus on\n")
  httpd_conf_file += sprintf("Port 80\n")
  httpd_conf_file += sprintf("User www-data\n")
  httpd_conf_file += sprintf("Group www-data\n")
  httpd_conf_file += sprintf("ServerAdmin webmaster@personaltelco.net\n")
  httpd_conf_file += sprintf("ServerName %s.node.personaltelco.net\n",
                             host['hostname'])
  httpd_conf_file += sprintf("DocumentRoot /srv/www/ptp\n\n")

  httpd_conf_file += sprintf("<Directory />\n")
  httpd_conf_file += sprintf("  Options SymLinksIfOwnerMatch\n")
  httpd_conf_file += sprintf("  AllowOverride None\n")
  httpd_conf_file += sprintf("</Directory>\n\n")

  httpd_conf_file += sprintf("<Directory /srv/www/ptp/>\n")
  httpd_conf_file += sprintf("  Options Indexes Includes " +
                               "FollowSymLinks MultiViews\n")
  httpd_conf_file += sprintf("  AllowOverride None\n")
  httpd_conf_file += sprintf("  Order allow,deny\n")
  httpd_conf_file += sprintf("  Allow from all\n")
  httpd_conf_file += sprintf("</Directory>\n\n")

  httpd_conf_file += sprintf("<IfModule mod_userdir.c>\n")
  httpd_conf_file += sprintf("  UserDir public_html\n")
  httpd_conf_file += sprintf("</IfModule>\n\n")

  httpd_conf_file += sprintf("<Directory /home/*/public_html>\n")
  httpd_conf_file += sprintf("  AllowOverride FileInfo AuthConfig Limit\n")
  httpd_conf_file += sprintf("  Options MultiViews Indexes " +
                               "SymLinksIfOwnerMatch IncludesNoExec\n")
  httpd_conf_file += sprintf("  <Limit GET POST OPTIONS PROPFIND>\n")
  httpd_conf_file += sprintf("    Order allow,deny\n")
  httpd_conf_file += sprintf("    Allow from all\n")
  httpd_conf_file += sprintf("  </Limit>\n")
  httpd_conf_file += sprintf("  <Limit PUT DELETE PATCH PROPPATCH " +
                               "MKCOL COPY MOVE LOCK UNLOCK>\n")
  httpd_conf_file += sprintf("    Order deny,allow\n")
  httpd_conf_file += sprintf("    Deny from all\n")
  httpd_conf_file += sprintf("  </Limit>\n")
  httpd_conf_file += sprintf("</Directory>\n\n")

  httpd_conf_file += sprintf("<IfModule mod_dir.c>\n")
  httpd_conf_file += sprintf("  DirectoryIndex index.html " +
                               "index.htm index.shtml index.cgi\n")
  httpd_conf_file += sprintf("</IfModule>\n\n")

  httpd_conf_file += sprintf("AccessFileName .htaccess\n")
  httpd_conf_file += sprintf("<Files ~ \"^\\.ht\">\n")
  httpd_conf_file += sprintf("  Order allow,deny\n")
  httpd_conf_file += sprintf("  Deny from all\n")
  httpd_conf_file += sprintf("</Files>\n\n")

  httpd_conf_file += sprintf("UseCanonicalName on\n")
  httpd_conf_file += sprintf("TypesConfig /etc/mime.types\n")
  httpd_conf_file += sprintf("DefaultType text/plain\n")
  httpd_conf_file += sprintf("<IfModule mod_mime_magic.c>\n")
  httpd_conf_file += sprintf("  MIMEMagicFile share/magic\n")
  httpd_conf_file += sprintf("</IfModule>\n\n")

  httpd_conf_file += sprintf("HostnameLookups off\n")
  httpd_conf_file += sprintf("ErrorLog /var/log/apache/error.log\n")
  httpd_conf_file += sprintf("LogLevel warn\n")
  httpd_conf_file += sprintf("LogFormat \"%%h %%l %%u %%t \\\"%%r\\\" %%>s " +
                               "%%b \\\"%%{Referer}i\\\" " +
                               "\\\"%%{User-Agent}i\\\" %%T %%v\" full\n")
  httpd_conf_file += sprintf("LogFormat \"%%h %%l %%u %%t \\\"%%r\\\" %%>s " +
                               "%%b \\\"%%{Referer}i\\\" " +
                               "\\\"%%{User-Agent}i\\\" %%P %%T\" debug\n")
  httpd_conf_file += sprintf("LogFormat \"%%h %%l %%u %%t \\\"%%r\\\" %%>s " +
                               "%%b \\\"%%{Referer}i\\\" " +
                               "\\\"%%{User-Agent}i\\\"\" combined\n")
  httpd_conf_file += sprintf("LogFormat \"%%h %%l %%u %%t \\\"%%r\\\" %%>s " +
                               "%%b\" common\n")
  httpd_conf_file += sprintf("LogFormat \"%%{Referer}i -> %%U\" referer\n")
  httpd_conf_file += sprintf("LogFormat \"%%{User-agent}i\" agent\n")
  httpd_conf_file += sprintf("CustomLog /var/log/apache/access.log combined\n")
  httpd_conf_file += sprintf("ServerSignature on\n\n")

  httpd_conf_file += sprintf("Alias /icons/ /usr/share/apache/icons/\n")
  httpd_conf_file += sprintf("<Directory /usr/share/apache/icons>\n")
  httpd_conf_file += sprintf("  Options Indexes MultiViews\n")
  httpd_conf_file += sprintf("  AllowOverride None\n")
  httpd_conf_file += sprintf("  Order allow,deny\n")
  httpd_conf_file += sprintf("  Allow from all\n")
  httpd_conf_file += sprintf("</Directory>\n\n")

  httpd_conf_file += sprintf("ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/\n")
  httpd_conf_file += sprintf("<Directory /usr/lib/cgi-bin/>\n")
  httpd_conf_file += sprintf("  AllowOverride None\n")
  httpd_conf_file += sprintf("  Options ExecCGI\n")
  httpd_conf_file += sprintf("  Order allow,deny\n")
  httpd_conf_file += sprintf("  Allow from all\n")
  httpd_conf_file += sprintf("</Directory>\n\n")

  httpd_conf_file += sprintf("<IfModule mod_autoindex.c>\n")
  httpd_conf_file += sprintf("  IndexOptions FancyIndexing NameWidth=*\n")
  httpd_conf_file += sprintf("  AddIconByEncoding " +
                               "(CMP,/icons/compressed.gif) " +
                               "x-compress x-gzip\n")
  httpd_conf_file += sprintf("  AddIconByType (TXT,/icons/text.gif) text/*\n")
  httpd_conf_file += sprintf("  AddIconByType " +
                               "(IMG,/icons/image2.gif) image/*\n")
  httpd_conf_file += sprintf("  AddIconByType " +
                               "(SND,/icons/sound2.gif) audio/*\n")
  httpd_conf_file += sprintf("  AddIconByType " +
                               "(VID,/icons/movie.gif) video/*\n")
  httpd_conf_file += sprintf("  AddIcon /icons/binary.gif .bin .exe\n")
  httpd_conf_file += sprintf("  AddIcon /icons/binhex.gif .hqx\n")
  httpd_conf_file += sprintf("  AddIcon /icons/tar.gif .tar\n")
  httpd_conf_file += sprintf("  AddIcon /icons/world2.gif " +
                               ".wrl .wrl.gz .vrml .vrm .iv\n")
  httpd_conf_file += sprintf("  AddIcon /icons/compressed.gif " +
                               ".Z .z .tgz .gz .zip\n")
  httpd_conf_file += sprintf("  AddIcon /icons/a.gif .ps .ai .eps\n")
  httpd_conf_file += sprintf("  AddIcon /icons/layout.gif " +
                               ".html .shtml .htm .pdf\n")
  httpd_conf_file += sprintf("  AddIcon /icons/text.gif .txt\n")
  httpd_conf_file += sprintf("  AddIcon /icons/c.gif .c\n")
  httpd_conf_file += sprintf("  AddIcon /icons/p.gif .pl .py\n")
  httpd_conf_file += sprintf("  AddIcon /icons/f.gif .for\n")
  httpd_conf_file += sprintf("  AddIcon /icons/dvi.gif .dvi\n")
  httpd_conf_file += sprintf("  AddIcon /icons/uuencoded.gif .uu\n")
  httpd_conf_file += sprintf("  AddIcon /icons/script.gif " +
                               ".conf .sh .shar .csh .ksh .tcl\n")
  httpd_conf_file += sprintf("  AddIcon /icons/tex.gif .tex\n")
  httpd_conf_file += sprintf("  AddIcon /icons/bomb.gif core\n")
  httpd_conf_file += sprintf("  AddIcon /icons/deb.gif .deb\n")
  httpd_conf_file += sprintf("  AddIcon /icons/back.gif ..\n")
  httpd_conf_file += sprintf("  AddIcon /icons/hand.right.gif README\n")
  httpd_conf_file += sprintf("  AddIcon /icons/folder.gif ^^DIRECTORY^^\n")
  httpd_conf_file += sprintf("  AddIcon /icons/blank.gif ^^BLANKICON^^\n")
  httpd_conf_file += sprintf("  DefaultIcon /icons/unknown.gif\n")
  httpd_conf_file += sprintf("  ReadmeName README\n")
  httpd_conf_file += sprintf("  HeaderName HEADER\n")
  httpd_conf_file += sprintf("  IndexIgnore " +
                               ".??* *~ *# HEADER* README* RCS CVS *,v *,t\n")
  httpd_conf_file += sprintf("</IfModule>\n\n")

  httpd_conf_file += sprintf("<IfModule mod_mime.c>\n")
  httpd_conf_file += sprintf("  AddEncoding x-compress Z\n")
  httpd_conf_file += sprintf("  AddEncoding x-gzip gz tgz\n")
  httpd_conf_file += sprintf("  AddLanguage da .dk\n")
  httpd_conf_file += sprintf("  AddLanguage nl .nl\n")
  httpd_conf_file += sprintf("  AddLanguage en .en\n")
  httpd_conf_file += sprintf("  AddLanguage et .ee\n")
  httpd_conf_file += sprintf("  AddLanguage fr .fr\n")
  httpd_conf_file += sprintf("  AddLanguage de .de\n")
  httpd_conf_file += sprintf("  AddLanguage el .el\n")
  httpd_conf_file += sprintf("  AddLanguage it .it\n")
  httpd_conf_file += sprintf("  AddLanguage ja .ja\n")
  httpd_conf_file += sprintf("  AddCharset ISO-2022-JP .jis\n")
  httpd_conf_file += sprintf("  AddLanguage pl .po\n")
  httpd_conf_file += sprintf("  AddCharset ISO-8859-2 .iso-pl\n")
  httpd_conf_file += sprintf("  AddLanguage pt .pt\n")
  httpd_conf_file += sprintf("  AddLanguage pt-br .pt-br\n")
  httpd_conf_file += sprintf("  AddLanguage ltz .lu\n")
  httpd_conf_file += sprintf("  AddLanguage ca .ca\n")
  httpd_conf_file += sprintf("  AddLanguage es .es\n")
  httpd_conf_file += sprintf("  AddLanguage sv .se\n")
  httpd_conf_file += sprintf("  AddLanguage cz .cz\n")
  httpd_conf_file += sprintf("  <IfModule mod_negotiation.c>\n")
  httpd_conf_file += sprintf("    LanguagePriority en da nl et fr de " +
                               "el it ja pl pt pt-br ltz ca es sv\n")
  httpd_conf_file += sprintf("  </IfModule>\n")
  httpd_conf_file += sprintf("  AddType application/x-tar .tgz\n")
  httpd_conf_file += sprintf("  AddType image/bmp .bmp\n")
  httpd_conf_file += sprintf("  AddType text/x-hdml .hdml\n")
  httpd_conf_file += sprintf("</IfModule>\n")
  httpd_conf_file += sprintf("AddDefaultCharset on\n\n")

  httpd_conf_file += sprintf("<IfModule mod_setenvif.c>\n")
  httpd_conf_file += sprintf("  BrowserMatch \"Mozilla/2\" nokeepalive\n")
  httpd_conf_file += sprintf("  BrowserMatch \"MSIE 4\.0b2;\" nokeepalive " +
                               "downgrade-1.0 force-response-1.0\n")
  httpd_conf_file += sprintf("  BrowserMatch \"RealPlayer 4\\.0\" " +
                               "force-response-1.0\n")
  httpd_conf_file += sprintf("  BrowserMatch \"Java/1\\.0\" " +
                               "force-response-1.0\n")
  httpd_conf_file += sprintf("  BrowserMatch \"JDK/1\\.0\" " +
                               "force-response-1.0\n")
  httpd_conf_file += sprintf("</IfModule>\n\n")

  begin
    httpd_conf_original = open("/etc/apache/httpd.conf").read
  rescue
  end

  # Compare it with the current local copy of /etc/apache/httpd.conf
  if httpd_conf_file != httpd_conf_original
    # Overwrite the existing data if it has changed
    fp = open("/var/lib/adhocracy/httpd.conf", "w")
    fp.write(httpd_conf_file)
    fp.close
  end
end
