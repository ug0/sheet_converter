class SheetConverter::CLI < Thor
  desc "xlsx2csv INPUT_PATH", "convert XLSX files to CSV files at the same folder"
  option :output, aliases: [:o], desc: "specify the output directory"
  def xlsx2csv(input_path)
    if File.directory?(input_path)
      Dir.glob(File.join(input_path, "**", "*.xlsx")).each do |xlsx|
        file_xlsx_to_csv(xlsx, dir: options[:output])
      end
    else
      file_xlsx_to_csv(input_path, dir: options[:output])
    end
  end

  private

  def file_xlsx_to_csv(xlsx, dir: nil)
    extname = File.extname(xlsx)
    basename = File.basename(xlsx, extname)
    dir = dir || File.dirname(xlsx)
    Dir.mkdir(dir) unless Dir.exist?(dir)
    csv = "#{basename}.csv"

    File.write(File.join(dir, csv), Roo::Excelx.new(xlsx).to_csv)
  end
end