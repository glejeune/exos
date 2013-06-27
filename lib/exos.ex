defmodule ExOS do
  @on_load { :init, 0 }

  def init do
    file = Path.expand('../../share/exos_nif', __FILE__)
    :ok = :erlang.load_nif(binary_to_list(file), 1)
  end

  def username() do
    username(uid())
  end
  def username(_) do
    exit(:nif_library_not_loaded)
  end

  def uid() do
    exit(:nif_library_not_loaded)
  end

  def group() do
    group(gid())
  end
  def group(_) do
    exit(:nif_library_not_loaded)
  end

  def gid() do
    exit(:nif_library_not_loaded)
  end

  def home() do
    exit(:nif_library_not_loaded)
  end

  def family() do
    {family, _} = :os.type()
    family
  end

  def name() do
    {_, name} = :os.type()
    name
  end

  def version() do
    version = :os.version()
    case version do
      {major, minor, release} -> :io_lib.format "~p.~p.~p", [ major, minor, release ]
      _ -> version
    end
  end
end

