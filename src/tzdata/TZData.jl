module TZData

using Printf
using ...TimeZones: DEPS_DIR

# Note: The tz database is made up of two parts: code and data. TimeZones.jl only requires
# the "tzdata" archive or more specifically the "tz source" files within the archive
# (africa, australasia, ...)

const ARCHIVE_DIR = joinpath(DEPS_DIR, "tzarchive")
const TZ_SOURCE_DIR = joinpath(DEPS_DIR, "tzsource")
const COMPILED_DIR = joinpath(DEPS_DIR, "compiled")

export ARCHIVE_DIR, TZ_SOURCE_DIR, COMPILED_DIR, REGIONS, LEGACY_REGIONS

function __init__()
    @static if Sys.iswindows()
        # https://github.com/JuliaLang/julia/pull/33592
        global exe7z = if VERSION >= v"1.4.0-DEV.349"
            joinpath(Sys.BINDIR, "7z.exe")
        else
            joinpath(Sys.BINDIR, "..", "libexec", "7z.exe")
        end
    end
end

include("timeoffset.jl")
include("archive.jl")
include("version.jl")
include("download.jl")
include("compile.jl")
include("build.jl")
include("deprecated.jl")

end
