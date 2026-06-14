# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If the target framework does not match your intended version, update it and re-run `dotnet restore` and `dotnet build`.

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify that existing functionality behaves as expected after the migration:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime or by incomplete migration of specific components.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently or have been removed in cross-platform .NET compared to .NET Framework. Pay particular attention to the following areas if they are used in the project:

- **`System.Web`**: This namespace is not available in cross-platform .NET. Any dependencies on `HttpContext`, `HttpRequest`, or related types should be migrated to `Microsoft.AspNetCore.Http` equivalents.
- **`System.Configuration.ConfigurationManager`**: Requires the `System.Configuration.ConfigurationManager` NuGet package or migration to `Microsoft.Extensions.Configuration`.
- **Windows Registry / WMI**: These are Windows-only APIs and will not function on Linux or macOS.
- **Entity Framework**: If using Entity Framework 6, consider migrating to Entity Framework Core for full cross-platform support.

### 6. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's key workflows and confirm that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 7. Review Application Logs

After running the application, review the console output and any log files for runtime exceptions or warnings that would not have been caught at build time.

### 8. Test on Target Platforms

If cross-platform support is a requirement, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues.

### 9. Publish the Application

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present. For a self-contained deployment, add the `--self-contained true` flag along with the appropriate `--runtime` identifier, for example:

```bash
dotnet publish --configuration Release --self-contained true --runtime linux-x64 --output ./publish
```

Refer to the [.NET RID Catalog](https://learn.microsoft.com/en-us/dotnet/core/rid-catalog) for a full list of supported runtime identifiers.