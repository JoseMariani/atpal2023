# WickedPDF Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `render :pdf` call.
#
# To learn more, check out the README:
#
# https://github.com/mileszs/wicked_pdf/blob/master/README.md

if RbConfig::CONFIG['host_os'] =~ /linux/
  path = ENV['RAILS_ENV'] == 'development' ? '/usr/local/bin/wkhtmltopdf' : '/usr/bin/wkhtmltopdf'
elsif RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw|cygwin|bccwin|wince|emc/
  path = 'C:\pdf_addon\wkhtmltopdf\bin\wkhtmltopdf.exe'
elsif RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
  path = '/usr/local/bin/wkhtmltopdf'
end

WickedPdf.config = {
  # Path to the wkhtmltopdf executable: This usually isn't needed if using
  # one of the wkhtmltopdf-binary family of gems.
  exe_path: path
  #   or
  # exe_path: Gem.bin_path('wkhtmltopdf-binary', 'wkhtmltopdf')

  # Layout file to be used for all PDFs
  # (but can be overridden in `render :pdf` calls)
  # layout: 'pdf.html',
}

