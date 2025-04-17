load("@rules_cc//cc:cc_library.bzl", "cc_library")
load("@rules_cc//cc:cc_shared_library.bzl", "cc_shared_library")

PREFIX = "open_spiel/open_spiel"

# Can make this a cc_library, but have to do deps management.
filegroup(
    name = "absl_headers",
    srcs = glob(["absl_headers/**/*.h"]),
)

cc_library(
    name = "open_spiel",
    srcs = glob(
        [
            PREFIX + "/*.cc",
            PREFIX + "/algorithms/*.cc",
            PREFIX + "/algorithms/corr_dist/**/*.cc",
            PREFIX + "/game_transforms/**/*.cc",
            PREFIX + "/games/**/*.cc",
            PREFIX + "/rust/**/*.cc",
            PREFIX + "/utils/**/*.cc",
        ],
        exclude = [
            PREFIX + "**/*_generator.cc",  # These tend to be main files.
            PREFIX + "**/*_test.cc",
            PREFIX + "/games/bridge/**/*",
            PREFIX + "/games/gamut/**/*",
            PREFIX + "/games/hanabi/**/*",
            PREFIX + "/games/universal_poker/**/*",
        ],
    ),
    hdrs = glob(
        [
            PREFIX + "/*.h",
            PREFIX + "/algorithms/*.h",
            PREFIX + "/algorithms/corr_dist/**/*.h",
            PREFIX + "/game_transforms/**/*.h",
            PREFIX + "/games/**/*.h",
            PREFIX + "/rust/**/*.h",
            PREFIX + "/utils/**/*.h",
        ],
        exclude = [
            PREFIX + "/games/bridge/**/*",
            PREFIX + "/games/gamut/**/*",
            PREFIX + "/games/hanabi/**/*",
            PREFIX + "/games/universal_poker/**/*",
        ],
    ),
    additional_compiler_inputs = [":absl_headers"],
    copts = ["-w"],
    includes = ["absl_headers"],
    strip_include_prefix = "open_spiel",
    visibility = ["//visibility:public"],
    deps = [
        "@abseil-cpp//absl/algorithm:container",
        "@abseil-cpp//absl/container:btree",
        "@abseil-cpp//absl/container:flat_hash_map",
        "@abseil-cpp//absl/container:flat_hash_set",
        "@abseil-cpp//absl/container:node_hash_map",
        "@abseil-cpp//absl/random",
        "@abseil-cpp//absl/random:bit_gen_ref",
        "@abseil-cpp//absl/types:optional",
    ],
    alwayslink = 1,
)

cc_shared_library(
    name = "open_spiel_shared",
    visibility = ["//visibility:public"],
    deps = [":open_spiel"],
)
