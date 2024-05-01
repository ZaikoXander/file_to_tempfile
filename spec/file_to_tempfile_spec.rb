# frozen_string_literal: true

RSpec.describe FileToTempfile do
  it "has a version number" do
    expect(FileToTempfile::VERSION).not_to be nil
  end

  describe '#self.convert' do
    context 'when file is not a File object' do
      it 'raises an ArgumentError' do
        expect do
          FileToTempfile.convert('file')
        end.to raise_error ArgumentError, 'Expected a File object as the first argument'
      end
    end

    context 'when file is a File object' do
      let(:file) { File.open '.gitignore' }

      context 'when file is open' do
        context 'when file has not been read' do
          it 'converts a file to a Tempfile' do
            tempfile = FileToTempfile.convert(file)

            expect(tempfile).to be_a Tempfile
            expect(file.read).to eq tempfile.read
            expect(tempfile.path).to start_with "/tmp/"
          end
        end

        context 'when file has been read' do
          before { file.read }

          it 'converts a file to a Tempfile' do
            tempfile = FileToTempfile.convert(file)

            expect(tempfile).to be_a Tempfile
            expect(file.read).to eq tempfile.read
            expect(tempfile.path).to start_with "/tmp/"
          end
        end

        context 'when using_path is true' do
          it 'converts a file to a Tempfile' do
            tempfile = FileToTempfile.convert(file, true)

            expect(tempfile).to be_a Tempfile
            expect(file.read).to eq tempfile.read
            expect(tempfile.path).to start_with "/tmp/#{file.path}"
          end
        end
      end

      context 'when file has been closed' do
        before { file.close }

        it 'raises an error' do
          expect do
            FileToTempfile.convert(file)
          end.to raise_error IOError, 'The file must be open before it can be converted'
        end
      end
    end
  end
end
