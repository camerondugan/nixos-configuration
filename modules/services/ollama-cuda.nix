{
  flake.nixosModules.ollama-cuda = {
    pkgs,
    lib,
    ...
  }: {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "cuda_cudart"
        "cuda_nvcc"
        "cuda_cccl"
        "libcublas"
      ];
    services.ollama.package = pkgs.ollama-cuda;
  };
}
