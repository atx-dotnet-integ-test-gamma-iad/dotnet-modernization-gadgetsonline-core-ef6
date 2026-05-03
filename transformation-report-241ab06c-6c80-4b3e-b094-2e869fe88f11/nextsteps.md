# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts that may cause runtime issues even if they do not produce build errors.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). Avoid `netcoreapp3.1` or `net5.0` as these are end-of-life.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally
Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key pages and features to confirm basic functionality is intact.

### 5. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies** — these are not available in .NET Core/5+. Confirm no runtime references remain.
- **Windows-specific APIs** — features such as the Windows Registry, `System.Drawing` (GDI+), or MSMQ may throw `PlatformNotSupportedException` at runtime on non-Windows systems.
- **Entity Framework** — if the project uses EF6, confirm whether it has been migrated to EF Core, as EF6 has limited cross-platform support.
- **Configuration** — ensure `web.config` settings have been migrated to `appsettings.json` and that `IConfiguration` is used appropriately.

### 6. Run Existing Tests
If the solution contains test projects, execute them to catch any behavioral regressions:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate runtime incompatibilities not surfaced by the build.

### 7. Check Static Files and Middleware
If this is an ASP.NET Core web application, verify that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Confirm that the middleware pipeline matches the expected behavior of the original application.

### 8. Review Logging and Error Handling
Run the application under load or navigate through error-prone paths and review application logs. Ensure logging is configured via `Microsoft.Extensions.Logging` and that unhandled exceptions are surfaced appropriately.

## Deployment

### 1. Publish the Application
Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Published Output
Inspect the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and the compiled assemblies.

### 3. Test the Published Output
Run the published application directly to confirm it behaves identically to the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

### 4. Confirm Runtime is Available on the Target Server
Ensure the target server has the correct .NET runtime installed. You can verify this with:

```bash
dotnet --list-runtimes
```

If deploying a self-contained application, this step is not required. To publish as self-contained, add the following flags:

```bash
dotnet publish --configuration Release --self-contained true --runtime win-x64 --output ./publish
```

Replace `win-x64` with the appropriate runtime identifier for your target environment (e.g., `linux-x64`, `osx-x64`).