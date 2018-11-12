class SheetConverter::CLI < Thor
  desc "xlsx2csv INPUT_PATH", "convert XLSX files to CSV files at the same folder"
  option :output, aliases: [:o], desc: "specify the output directory"
  def xlsx2csv(input_path)
    nav_input_files(input_path, ".xlsx") do |file|
      file_xlsx_to_csv(file, dir: options[:output])
    end
  end

  desc "csv2xlsx INPUT_PATH", "convert CSV files to XLSX files at the same folder"
  option :output, aliases: [:o], desc: "specify the output directory"
  def csv2xlsx(input_path)
    nav_input_files(input_path, ".csv") do |file|
      file_csv_to_xlsx(file, dir: options[:output])
    end
  end

  private

  def file_xlsx_to_csv(xlsx_path, dir: nil)
    csv = Roo::Excelx.new(xlsx_path).to_csv
    File.write(parse_file_output_path(xlsx_path, output_ext: '.csv', dir: dir), csv)
  end

  def file_csv_to_xlsx(csv_path, dir: nil)
    csv = Roo::CSV.new(csv_path)
    headers = csv.row(1)

    xlsx = SpreadsheetArchitect.to_xlsx(headers: headers, data: csv.to_a[1..-1])
    File.write(parse_file_output_path(csv_path, output_ext: '.xlsx', dir: dir), xlsx)
  end

  def nav_input_files(input_path, ext, &blk)
    if File.directory?(input_path)
      Dir.glob(File.join(input_path, "**", "*#{ext}")).each(&blk)
    else
      blk.call(input_path)
    end
  end

  def parse_file_output_path(filepath, output_ext:, dir: nil)
    extname = File.extname(filepath)
    basename = File.basename(filepath, extname)
    dir = dir || File.dirname(filepath)
    Dir.mkdir(dir) unless Dir.exist?(dir)

    File.join(dir, [basename, output_ext].join)
  end
end