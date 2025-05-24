let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKgYrw3DhPtjLsF71tIhpw1YRDIWrqiLY9ldVHh3G6rp"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOyRb+qQCI4z8jqSNgzj/K8cptZbFuAZwF5I+6A0ZMF6"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKEkN+yp4avsJFFdPIIvRoitL3BpeBbEqwAKEXGEZSZu"
  ];
in {
  "cf.age".publicKeys = keys;
}
