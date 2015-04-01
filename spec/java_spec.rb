require 'serverspec'

describe 'Oracle Java' do

  let(:java) { Java.new(self) }

  describe 'the os' do
    it 'is ubuntu' do
      expect(host_inventory['platform']).to eq 'ubuntu'
    end

    it 'is version 14.04 LTS' do
      expect(host_inventory['platform_version']).to eq '14.04'
    end
  end

  it 'installs oracle java' do
    expect(java).to be_oracle
  end

  it 'installs a jdk' do
    expect(java).to be_jdk
  end

  it 'installs version 1.8.0', :'1.8.0' do
    expect(java.version).to eq '1.8.0'
  end

  it 'installs version 1.7.0', :'1.7.0' do
    expect(java.version).to eq '1.7.0'
  end

  it 'installs at least update 20', :'1.8.0' do
    expect(java.update).to be >= 20
  end

  it 'installs at least update 55', :'1.7.0' do
    expect(java.update).to be >= 55
  end

  class Java
    def initialize(context)
      @context = context
    end

    def version
      java_version_string.split('"')[1].split('_').first
    end

    def update
      java_version_string.split('"')[1].split('_').last.to_i
    end

    def oracle?
      java_version_string.include? 'Java(TM) SE Runtime Environment'
    end

    def jdk?
      context.command('javac -version').exit_status == 0
    end

    private

    attr_reader :context

    def java_version_string
      @_java_version_string ||= context.command('java -version').stderr
    end
  end

end
